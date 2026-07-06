import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';

import '../db/database.dart';
import '../db/tables.dart';
import '../models/reference.dart';

/// Outcome of an import run.
class ImportResult {
  const ImportResult({required this.added, required this.updated});
  final int added;
  final int updated;
  int get total => added + updated;
}

/// Outcome of an export: the JSON document and how many local-only books were
/// skipped (they can't move devices).
class ExportResult {
  const ExportResult({required this.json, required this.localBooksSkipped});
  final String json;
  final int localBooksSkipped;
}

/// Owns library reads and the import/upsert pipeline.
///
/// Import is keyed on the manga [identifier]: a missing identifier is a new
/// series (full insert), an existing one is an update that preserves favorites,
/// reading progress, and downloaded files while refreshing metadata, chapters,
/// and pages.
class MangaRepository {
  MangaRepository(this._db);

  final AppDatabase _db;

  Stream<List<MangaRow>> watchLibrary() => _db.mangaDao.watchAllManga();

  Future<List<MangaRow>> getLibrary() => _db.mangaDao.getAllManga();

  /// Toggles favorite state. Favoriting assigns the next free ordering slot so
  /// newly favorited items append to the end of the favorites section;
  /// unfavoriting clears the ordering.
  Future<void> toggleFavorite(MangaRow manga) async {
    if (manga.isFavorite) {
      await _db.mangaDao
          .setFavorite(manga.identifier, false, favoriteOrder: null);
      return;
    }
    await _db.mangaDao
        .setFavorite(manga.identifier, true, favoriteOrder: await _nextFavoriteOrder());
  }

  Future<void> toggleFavoriteByIdentifier(String identifier) async {
    final manga = await _db.mangaDao.getByIdentifier(identifier);
    if (manga != null) await toggleFavorite(manga);
  }

  /// Next favorite slot across the *whole* library (manga + books), so mixed
  /// favorites share one ordering.
  Future<int> _nextFavoriteOrder() async {
    final manga = await _db.mangaDao.getAllManga();
    final books = await _db.bookDao.getAll();
    final orders = [
      ...manga.map((m) => m.favoriteOrder),
      ...books.map((b) => b.favoriteOrder),
    ].whereType<int>();
    return (orders.isEmpty ? -1 : orders.reduce((a, b) => a > b ? a : b)) + 1;
  }

  /// Persists a new favorites ordering (used by drag-to-reorder in a later
  /// phase). [orderedIdentifiers] is the favorites list top-to-bottom.
  Future<void> reorderFavorites(List<String> orderedIdentifiers) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIdentifiers.length; i++) {
        await _db.mangaDao
            .setFavorite(orderedIdentifiers[i], true, favoriteOrder: i);
      }
    });
  }

  Future<ImportResult> import(List<ReferenceManga> refs) async {
    var added = 0;
    var updated = 0;

    await _db.transaction(() async {
      for (final ref in refs) {
        // A reference with a book type is a PDF/EPUB, not a manga.
        if (ref.type == 'pdf' || ref.type == 'epub') {
          final isNew = await _upsertBook(ref);
          isNew ? added++ : updated++;
          continue;
        }

        final existing = await _db.mangaDao.getByIdentifier(ref.identifier);
        if (existing == null) {
          added++;
        } else {
          updated++;
        }

        // Only title/thumbnail/updatedAt are written; favorite, ordering, and
        // last-read fields are left absent so an upsert preserves them.
        await _db.mangaDao.upsertManga(
          MangaTableCompanion(
            identifier: Value(ref.identifier),
            title: Value(ref.title),
            thumbnail: Value(ref.thumbnail),
            updatedAt: Value(DateTime.now()),
          ),
        );

        await _reconcileChapters(ref);
        await _applyProgress(ref);
        await _applyFavoritePages(ref);
      }
    });

    return ImportResult(added: added, updated: updated);
  }

  /// Restores favorited pages from the imported document (idempotent — existing
  /// favorites aren't duplicated).
  Future<void> _applyFavoritePages(ReferenceManga ref) async {
    for (final fav in ref.favoritePages) {
      final chapter =
          await _db.chapterDao.getBySource(ref.identifier, fav.chapter);
      if (chapter == null) continue;
      final maxIndex = chapter.pageCount > 0 ? chapter.pageCount - 1 : 0;
      final pageIndex = (fav.page - 1).clamp(0, maxIndex);
      await _db.favoritePageDao.add(ref.identifier, chapter.id, pageIndex);
    }
  }

  /// Upserts a book from a reference object (keyed on identifier). Returns true
  /// if it was newly added. The file itself is downloaded on first read.
  Future<bool> _upsertBook(ReferenceManga ref) async {
    final existing = await _db.bookDao.getByIdentifier(ref.identifier);
    final now = DateTime.now();
    if (existing == null) {
      await _db.bookDao.insertBook(
        BookTableCompanion.insert(
          title: ref.title,
          type: ref.type!,
          filePath: '', // downloaded on first read
          identifier: Value(ref.identifier),
          sourceUrl: Value(ref.url),
          coverUrl: Value(ref.thumbnail),
          author: Value(ref.author),
          series: Value(ref.series),
        ),
      );
      return true;
    }

    // If the source URL changed, drop the stale download so it re-fetches.
    var filePath = existing.filePath;
    if (existing.sourceUrl != ref.url && filePath.isNotEmpty) {
      final file = File(filePath);
      if (file.existsSync()) {
        try {
          file.deleteSync();
        } catch (_) {}
      }
      filePath = '';
    }
    await _db.bookDao.updateBook(
      existing.id,
      BookTableCompanion(
        title: Value(ref.title),
        type: Value(ref.type!),
        sourceUrl: Value(ref.url),
        coverUrl: Value(ref.thumbnail),
        author: Value(ref.author),
        series: Value(ref.series),
        filePath: Value(filePath),
        updatedAt: Value(now),
      ),
    );
    return false;
  }

  /// Applies an optional resume marker from the imported document, mapping the
  /// 1-based `page` to the internal 0-based index.
  Future<void> _applyProgress(ReferenceManga ref) async {
    final progress = ref.progress;
    if (progress == null) return;
    final chapter =
        await _db.chapterDao.getBySource(ref.identifier, progress.chapter);
    if (chapter == null) return;
    final maxIndex = chapter.pageCount > 0 ? chapter.pageCount - 1 : 0;
    final pageIndex = (progress.page - 1).clamp(0, maxIndex);
    await _db.chapterDao.updateProgress(chapter.id, pageIndex);
    await _db.mangaDao.touchLastRead(ref.identifier, chapter.id);

    // Everything before the resume chapter is implicitly read.
    final chapters = await _db.chapterDao.getChaptersForManga(ref.identifier);
    for (final c in chapters) {
      if (c.sortOrder < chapter.sortOrder && !c.isRead) {
        final lastIndex = c.pageCount > 0 ? c.pageCount - 1 : 0;
        await _db.chapterDao.updateProgress(c.id, lastIndex, isRead: true);
      }
    }
  }

  /// Result of an export: the JSON string, plus how many local-only books were
  /// skipped (they have no shared source and can't move devices).
  Future<ExportResult> exportLibraryJson({
    required bool includeProgress,
    required bool includeFavoritePages,
  }) async {
    final mangas = await _db.mangaDao.getAllManga();
    final out = <Map<String, dynamic>>[];

    for (final m in mangas) {
      // Skip any single entry that fails to build rather than failing the
      // whole export.
      try {
        out.add(await _mangaToJson(m, includeProgress, includeFavoritePages));
      } catch (_) {
        continue;
      }
    }

    var localBooksSkipped = 0;
    for (final b in await _db.bookDao.getAll()) {
      final url = b.sourceUrl;
      final id = b.identifier;
      // Only URL-imported books can be re-imported elsewhere.
      if (url == null || url.isEmpty || id == null || id.isEmpty) {
        localBooksSkipped++;
        continue;
      }
      try {
        out.add({
          'title': b.title,
          'identifier': id,
          'thumbnail': b.coverUrl ?? '',
          'type': b.type,
          'url': url,
          if (b.author != null && b.author!.isNotEmpty) 'author': b.author,
          if (b.series != null && b.series!.isNotEmpty) 'series': b.series,
        });
      } catch (_) {
        continue;
      }
    }

    return ExportResult(
      json: const JsonEncoder.withIndent('  ').convert(out),
      localBooksSkipped: localBooksSkipped,
    );
  }

  Future<Map<String, dynamic>> _mangaToJson(
    MangaRow m,
    bool includeProgress,
    bool includeFavoritePages,
  ) async {
    final chapters = await _db.chapterDao.getChaptersForManga(m.identifier);
    final chapterById = {for (final c in chapters) c.id: c};
    final chapterMaps = <Map<String, dynamic>>[];
    for (final c in chapters) {
      final pages = await _db.pageDao.getPagesForChapter(c.id);
      chapterMaps.add({
        'id': c.sourceChapterId,
        'order': c.sortOrder,
        if (c.title != null && c.title!.isNotEmpty) 'title': c.title,
        'pages': pages.map((p) => p.url).toList(),
      });
    }

    Map<String, dynamic>? progress;
    if (includeProgress && m.lastReadChapterId != null) {
      final resume = chapterById[m.lastReadChapterId];
      if (resume != null) {
        progress = {
          'chapter': resume.sourceChapterId,
          'page': (resume.lastPageRead ?? 0) + 1,
        };
      }
    }

    List<Map<String, dynamic>>? favoritePages;
    if (includeFavoritePages) {
      final favs = await _db.favoritePageDao.getForManga(m.identifier);
      favoritePages = favs
          .map((f) => {
                'chapter': chapterById[f.chapterId]?.sourceChapterId,
                'page': f.pageIndex + 1,
              })
          .where((e) => e['chapter'] != null)
          .toList();
    }

    return {
      'title': m.title,
      'identifier': m.identifier,
      'thumbnail': m.thumbnail,
      if (progress != null) 'progress': progress,
      if (favoritePages != null && favoritePages.isNotEmpty)
        'favoritePages': favoritePages,
      'chapters': chapterMaps,
    };
  }

  Future<void> _reconcileChapters(ReferenceManga ref) async {
    for (final ch in ref.chapters) {
      final existing =
          await _db.chapterDao.getBySource(ref.identifier, ch.id);

      if (existing == null) {
        final chapterId = await _db.chapterDao.insertChapter(
          ChapterTableCompanion.insert(
            mangaId: ref.identifier,
            sourceChapterId: ch.id,
            title: Value(ch.title),
            sortOrder: ch.order,
            pageCount: Value(ch.pages.length),
          ),
        );
        await _db.pageDao.insertPages([
          for (var i = 0; i < ch.pages.length; i++)
            PageTableCompanion.insert(
              chapterId: chapterId,
              pageIndex: i,
              url: ch.pages[i],
            ),
        ]);
      } else {
        // Refresh pages (preserving downloaded files where the URL is unchanged)
        // and metadata, while leaving progress flags intact.
        await _reconcilePages(existing, ch);
        final pages = await _db.pageDao.getPagesForChapter(existing.id);
        final allDownloaded =
            pages.isNotEmpty && pages.every((p) => p.localPath != null);
        await _db.chapterDao.updateChapter(
          existing.id,
          ChapterTableCompanion(
            title: Value(ch.title),
            sortOrder: Value(ch.order),
            pageCount: Value(ch.pages.length),
            isDownloaded: Value(allDownloaded),
          ),
        );
      }
    }
  }

  Future<void> _reconcilePages(ChapterRow existing, ReferenceChapter ch) async {
    final oldPages = await _db.pageDao.getPagesForChapter(existing.id);
    final oldByIndex = {for (final p in oldPages) p.pageIndex: p};

    await _db.pageDao.deletePagesForChapter(existing.id);
    await _db.pageDao.insertPages([
      for (var i = 0; i < ch.pages.length; i++)
        PageTableCompanion.insert(
          chapterId: existing.id,
          pageIndex: i,
          url: ch.pages[i],
          // Keep the local file only if this page's URL is unchanged.
          localPath: (oldByIndex[i]?.url == ch.pages[i])
              ? Value(oldByIndex[i]!.localPath)
              : const Value.absent(),
        ),
    ]);
  }
}
