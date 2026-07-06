import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'book_dao.g.dart';

@DriftAccessor(tables: [BookTable])
class BookDao extends DatabaseAccessor<AppDatabase> with _$BookDaoMixin {
  BookDao(super.db);

  Stream<List<BookRow>> watchAll() => select(bookTable).watch();

  Future<List<BookRow>> getAll() => select(bookTable).get();

  Future<BookRow?> getById(int id) =>
      (select(bookTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<BookRow?> getByIdentifier(String identifier) =>
      (select(bookTable)..where((t) => t.identifier.equals(identifier)))
          .getSingleOrNull();

  Stream<BookRow?> watchById(int id) =>
      (select(bookTable)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<int> insertBook(Insertable<BookRow> book) =>
      into(bookTable).insert(book);

  Future<void> updateBook(int id, BookTableCompanion changes) =>
      (update(bookTable)..where((t) => t.id.equals(id))).write(changes);

  Future<void> deleteBook(int id) =>
      (delete(bookTable)..where((t) => t.id.equals(id))).go();

  Future<void> setFavorite(int id, bool isFavorite, {int? favoriteOrder}) =>
      updateBook(
        id,
        BookTableCompanion(
          isFavorite: Value(isFavorite),
          favoriteOrder: Value(favoriteOrder),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> touchLastRead(int id) => updateBook(
        id,
        BookTableCompanion(
          lastReadAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<void> savePdfPage(int id, int page) => updateBook(
        id,
        BookTableCompanion(lastPage: Value(page)),
      );

  Future<void> savePageCount(int id, int count) => updateBook(
        id,
        BookTableCompanion(pageCount: Value(count)),
      );

  Future<void> saveEpubLocation(int id, String cfi) => updateBook(
        id,
        BookTableCompanion(lastLocation: Value(cfi)),
      );
}
