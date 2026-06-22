import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'manga_dao.g.dart';

@DriftAccessor(tables: [MangaTable])
class MangaDao extends DatabaseAccessor<AppDatabase> with _$MangaDaoMixin {
  MangaDao(super.db);

  Future<List<MangaRow>> getAllManga() => select(mangaTable).get();

  Stream<List<MangaRow>> watchAllManga() => select(mangaTable).watch();

  Future<MangaRow?> getByIdentifier(String identifier) =>
      (select(mangaTable)..where((t) => t.identifier.equals(identifier)))
          .getSingleOrNull();

  Stream<MangaRow?> watchByIdentifier(String identifier) =>
      (select(mangaTable)..where((t) => t.identifier.equals(identifier)))
          .watchSingleOrNull();

  /// Insert or update keyed on the primary key ([identifier]).
  Future<void> upsertManga(Insertable<MangaRow> manga) =>
      into(mangaTable).insertOnConflictUpdate(manga);

  Future<void> setFavorite(
    String identifier,
    bool isFavorite, {
    int? favoriteOrder,
  }) =>
      (update(mangaTable)..where((t) => t.identifier.equals(identifier))).write(
        MangaTableCompanion(
          isFavorite: Value(isFavorite),
          favoriteOrder: Value(favoriteOrder),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Sets the per-manga reading direction override ('ltr', 'rtl', or null to
  /// follow the global default).
  Future<void> setReadingDirection(String identifier, String? direction) =>
      (update(mangaTable)..where((t) => t.identifier.equals(identifier))).write(
        MangaTableCompanion(
          readingDirection: Value(direction),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Records that [chapterId] was just opened, bumping last-read ordering.
  Future<void> touchLastRead(String identifier, int chapterId) =>
      (update(mangaTable)..where((t) => t.identifier.equals(identifier))).write(
        MangaTableCompanion(
          lastReadChapterId: Value(chapterId),
          lastReadAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );
}
