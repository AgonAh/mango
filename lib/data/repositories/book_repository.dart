import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:epubx/epubx.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import '../db/database.dart';
import '../db/tables.dart';

enum BookType { pdf, epub }

/// Suggested metadata + cover extracted from a picked file, before the user
/// confirms and the book is saved.
class BookDraft {
  BookDraft({
    required this.sourcePath,
    required this.type,
    required this.suggestedTitle,
    this.suggestedAuthor,
    this.coverBytes,
  });

  final String sourcePath;
  final BookType type;
  final String suggestedTitle;
  final String? suggestedAuthor;
  final Uint8List? coverBytes;
}

class BookRepository {
  BookRepository(this._db, this._dio);

  final AppDatabase _db;
  final Dio _dio;

  /// Ensures a JSON-imported book's file is present locally, downloading it on
  /// first use. Returns the book row with its (now) local [filePath].
  Future<BookRow> ensureLocalFile(BookRow book) async {
    if (book.filePath.isNotEmpty && File(book.filePath).existsSync()) {
      return book;
    }
    final url = book.sourceUrl;
    if (url == null || url.isEmpty) {
      throw 'This book has no file to open.';
    }
    final dir = await _booksDir();
    final ext = book.type == 'pdf' ? '.pdf' : '.epub';
    final dest =
        p.join(dir.path, '${book.id}-${DateTime.now().microsecondsSinceEpoch}$ext');
    await _dio.download(url, dest);
    await _db.bookDao.updateBook(
      book.id,
      BookTableCompanion(
        filePath: Value(dest),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return book.copyWith(filePath: dest);
  }

  Stream<List<BookRow>> watchBooks() => _db.bookDao.watchAll();

  Future<List<BookRow>> getBooks() => _db.bookDao.getAll();

  Future<void> toggleFavorite(BookRow book) async {
    if (book.isFavorite) {
      await _db.bookDao.setFavorite(book.id, false, favoriteOrder: null);
      return;
    }
    await _db.bookDao
        .setFavorite(book.id, true, favoriteOrder: await _nextFavoriteOrder());
  }

  Future<void> toggleFavoriteById(int id) async {
    final book = await _db.bookDao.getById(id);
    if (book != null) await toggleFavorite(book);
  }

  /// Next favorite slot across the whole library (manga + books).
  Future<int> _nextFavoriteOrder() async {
    final manga = await _db.mangaDao.getAllManga();
    final books = await _db.bookDao.getAll();
    final orders = [
      ...manga.map((m) => m.favoriteOrder),
      ...books.map((b) => b.favoriteOrder),
    ].whereType<int>();
    return (orders.isEmpty ? -1 : orders.reduce((a, b) => a > b ? a : b)) + 1;
  }

  BookType? typeForPath(String path) {
    switch (p.extension(path).toLowerCase()) {
      case '.pdf':
        return BookType.pdf;
      case '.epub':
        return BookType.epub;
      default:
        return null;
    }
  }

  /// Inspects a picked file and pulls out a suggested title/author and a cover
  /// image, without copying anything yet.
  Future<BookDraft> analyze(String path) async {
    final type = typeForPath(path);
    if (type == null) {
      throw 'Unsupported file — choose a .pdf or .epub';
    }
    var title = p.basenameWithoutExtension(path);
    String? author;
    Uint8List? cover;

    if (type == BookType.epub) {
      final bytes = await File(path).readAsBytes();
      final book = await EpubReader.readBook(bytes);
      if ((book.Title ?? '').trim().isNotEmpty) title = book.Title!.trim();
      author = book.Author;
      final coverImage = book.CoverImage;
      if (coverImage != null) {
        cover = Uint8List.fromList(img.encodeJpg(coverImage, quality: 80));
      }
    } else {
      final doc = await PdfDocument.openFile(path);
      try {
        final page = await doc.getPage(1);
        final rendered = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.jpeg,
        );
        cover = rendered?.bytes;
        await page.close();
      } finally {
        await doc.close();
      }
    }

    return BookDraft(
      sourcePath: path,
      type: type,
      suggestedTitle: title,
      suggestedAuthor: author,
      coverBytes: cover,
    );
  }

  Future<Directory> _booksDir() async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'books'));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  /// Copies the file into app storage, saves the cover, and inserts the row.
  Future<int> createBook({
    required BookDraft draft,
    required String title,
    String? author,
    String? series,
    required String readingMode,
    Uint8List? coverOverride,
  }) async {
    final dir = await _booksDir();
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final ext = draft.type == BookType.pdf ? '.pdf' : '.epub';
    final destPath = p.join(dir.path, '$stamp$ext');
    await File(draft.sourcePath).copy(destPath);

    final coverBytes = coverOverride ?? draft.coverBytes;
    String? coverPath;
    if (coverBytes != null) {
      coverPath = p.join(dir.path, '$stamp.jpg');
      await File(coverPath).writeAsBytes(coverBytes);
    }

    return _db.bookDao.insertBook(
      BookTableCompanion.insert(
        title: title,
        author: Value(author),
        series: Value(series),
        type: draft.type.name,
        filePath: destPath,
        coverPath: Value(coverPath),
        readingMode: Value(readingMode),
      ),
    );
  }

  Future<void> updateMetadata(
    int id, {
    required String title,
    String? author,
    String? series,
    String? readingMode,
    Uint8List? coverBytes,
  }) async {
    String? coverPath;
    if (coverBytes != null) {
      final dir = await _booksDir();
      coverPath = p.join(dir.path, 'cover-${DateTime.now().microsecondsSinceEpoch}.jpg');
      await File(coverPath).writeAsBytes(coverBytes);
    }
    await _db.bookDao.updateBook(
      id,
      BookTableCompanion(
        title: Value(title),
        author: Value(author),
        series: Value(series),
        readingMode:
            readingMode == null ? const Value.absent() : Value(readingMode),
        coverPath: coverPath == null ? const Value.absent() : Value(coverPath),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteBook(int id) async {
    final book = await _db.bookDao.getById(id);
    if (book == null) return;
    for (final path in [book.filePath, book.coverPath].whereType<String>()) {
      final file = File(path);
      if (file.existsSync()) {
        try {
          file.deleteSync();
        } catch (_) {
          // Ignore locked/missing files.
        }
      }
    }
    await _db.bookDao.deleteBook(id);
  }
}
