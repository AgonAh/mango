import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'page_dao.g.dart';

@DriftAccessor(tables: [PageTable])
class PageDao extends DatabaseAccessor<AppDatabase> with _$PageDaoMixin {
  PageDao(super.db);

  Future<List<PageRow>> getPagesForChapter(int chapterId) =>
      (select(pageTable)
            ..where((t) => t.chapterId.equals(chapterId))
            ..orderBy([(t) => OrderingTerm(expression: t.pageIndex)]))
          .get();

  Future<void> insertPages(List<Insertable<PageRow>> pages) async {
    await batch((b) => b.insertAll(pageTable, pages));
  }

  Future<void> deletePagesForChapter(int chapterId) =>
      (delete(pageTable)..where((t) => t.chapterId.equals(chapterId))).go();

  Future<void> setLocalPath(int pageId, String? localPath) =>
      (update(pageTable)..where((t) => t.id.equals(pageId)))
          .write(PageTableCompanion(localPath: Value(localPath)));

  /// Clears the local file reference for every page in a chapter (un-download).
  Future<void> clearLocalPaths(int chapterId) =>
      (update(pageTable)..where((t) => t.chapterId.equals(chapterId)))
          .write(const PageTableCompanion(localPath: Value<String?>(null)));
}
