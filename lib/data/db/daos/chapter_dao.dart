import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'chapter_dao.g.dart';

@DriftAccessor(tables: [ChapterTable])
class ChapterDao extends DatabaseAccessor<AppDatabase> with _$ChapterDaoMixin {
  ChapterDao(super.db);

  Future<List<ChapterRow>> getChaptersForManga(String mangaId) =>
      (select(chapterTable)
            ..where((t) => t.mangaId.equals(mangaId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();

  Stream<List<ChapterRow>> watchChaptersForManga(String mangaId) =>
      (select(chapterTable)
            ..where((t) => t.mangaId.equals(mangaId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .watch();

  Future<ChapterRow?> getById(int id) =>
      (select(chapterTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<ChapterRow?> getBySource(String mangaId, String sourceChapterId) =>
      (select(chapterTable)
            ..where((t) =>
                t.mangaId.equals(mangaId) &
                t.sourceChapterId.equals(sourceChapterId)))
          .getSingleOrNull();

  Future<int> insertChapter(Insertable<ChapterRow> chapter) =>
      into(chapterTable).insert(chapter);

  Future<void> updateChapter(int id, ChapterTableCompanion changes) =>
      (update(chapterTable)..where((t) => t.id.equals(id))).write(changes);

  /// Persists reading progress for a chapter. When [isRead] is omitted the flag
  /// is left untouched.
  Future<void> updateProgress(
    int chapterId,
    int lastPageRead, {
    bool? isRead,
  }) =>
      (update(chapterTable)..where((t) => t.id.equals(chapterId))).write(
        ChapterTableCompanion(
          lastPageRead: Value(lastPageRead),
          isRead: isRead == null ? const Value.absent() : Value(isRead),
          readUpdatedAt: Value(DateTime.now()),
        ),
      );

  /// Clears all reading progress for a chapter (used by "mark as unread").
  Future<void> clearProgress(int chapterId) =>
      (update(chapterTable)..where((t) => t.id.equals(chapterId))).write(
        const ChapterTableCompanion(
          lastPageRead: Value<int?>(null),
          isRead: Value(false),
          readUpdatedAt: Value<DateTime?>(null),
        ),
      );

  /// Number of chapters marked read for a manga (the "chapters read so far").
  Future<int> readChapterCount(String mangaId) async {
    final count = countAll();
    final query = selectOnly(chapterTable)
      ..addColumns([count])
      ..where(
          chapterTable.mangaId.equals(mangaId) & chapterTable.isRead.equals(true));
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
