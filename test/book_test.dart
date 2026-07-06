import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/db/tables.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('book CRUD, favorite, and location', () async {
    final id = await db.bookDao.insertBook(
      BookTableCompanion.insert(
        title: 'A Book',
        type: 'pdf',
        filePath: '/books/1.pdf',
        author: const Value('Someone'),
      ),
    );

    var book = await db.bookDao.getById(id);
    expect(book!.title, 'A Book');
    expect(book.author, 'Someone');
    expect(book.readingMode, 'scroll', reason: 'default reading mode');
    expect(book.isFavorite, isFalse);
    expect(book.lastPage, 0);

    await db.bookDao.setFavorite(id, true, favoriteOrder: 0);
    await db.bookDao.savePdfPage(id, 12);
    book = await db.bookDao.getById(id);
    expect(book!.isFavorite, isTrue);
    expect(book.favoriteOrder, 0);
    expect(book.lastPage, 12);

    await db.bookDao.deleteBook(id);
    expect(await db.bookDao.getById(id), isNull);
  });
}
