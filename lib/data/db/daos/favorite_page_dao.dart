import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'favorite_page_dao.g.dart';

/// A favorited page joined with its chapter and page rows, for display.
class FavoritePageView {
  FavoritePageView({
    required this.favorite,
    required this.chapter,
    required this.page,
  });

  final FavoritePageRow favorite;
  final ChapterRow chapter;
  final PageRow page;
}

@DriftAccessor(tables: [FavoritePageTable, ChapterTable, PageTable])
class FavoritePageDao extends DatabaseAccessor<AppDatabase>
    with _$FavoritePageDaoMixin {
  FavoritePageDao(super.db);

  /// Favorited pages for a manga, ordered by chapter then page, joined with
  /// chapter + page so the UI can show names and thumbnails.
  Stream<List<FavoritePageView>> watchForManga(String mangaId) {
    final query = select(favoritePageTable).join([
      innerJoin(
        chapterTable,
        chapterTable.id.equalsExp(favoritePageTable.chapterId),
      ),
      innerJoin(
        pageTable,
        pageTable.chapterId.equalsExp(favoritePageTable.chapterId) &
            pageTable.pageIndex.equalsExp(favoritePageTable.pageIndex),
      ),
    ])
      ..where(favoritePageTable.mangaId.equals(mangaId))
      ..orderBy([
        OrderingTerm(expression: chapterTable.sortOrder),
        OrderingTerm(expression: favoritePageTable.pageIndex),
      ]);

    return query.watch().map(
          (rows) => rows
              .map((r) => FavoritePageView(
                    favorite: r.readTable(favoritePageTable),
                    chapter: r.readTable(chapterTable),
                    page: r.readTable(pageTable),
                  ))
              .toList(),
        );
  }

  Stream<bool> watchIsFavorite(int chapterId, int pageIndex) {
    return (select(favoritePageTable)
          ..where((t) =>
              t.chapterId.equals(chapterId) & t.pageIndex.equals(pageIndex)))
        .watch()
        .map((rows) => rows.isNotEmpty);
  }

  Future<void> add(String mangaId, int chapterId, int pageIndex) =>
      into(favoritePageTable).insert(
        FavoritePageTableCompanion.insert(
          mangaId: mangaId,
          chapterId: chapterId,
          pageIndex: pageIndex,
        ),
        mode: InsertMode.insertOrIgnore,
      );

  Future<void> remove(int chapterId, int pageIndex) =>
      (delete(favoritePageTable)
            ..where((t) =>
                t.chapterId.equals(chapterId) & t.pageIndex.equals(pageIndex)))
          .go();

  Future<void> toggle(String mangaId, int chapterId, int pageIndex) async {
    final existing = await (select(favoritePageTable)
          ..where((t) =>
              t.chapterId.equals(chapterId) & t.pageIndex.equals(pageIndex)))
        .getSingleOrNull();
    if (existing == null) {
      await add(mangaId, chapterId, pageIndex);
    } else {
      await remove(chapterId, pageIndex);
    }
  }
}
