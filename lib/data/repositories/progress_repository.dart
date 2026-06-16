import '../db/database.dart';

/// Owns reading-progress writes: which chapter is current, the page within a
/// chapter, and whether a chapter is finished.
class ProgressRepository {
  ProgressRepository(this._db);

  final AppDatabase _db;

  /// Marks [chapterId] as the manga's current chapter and stamps last-read
  /// (which also flags the series as "started" for sorting).
  Future<void> openChapter(String mangaId, int chapterId) =>
      _db.mangaDao.touchLastRead(mangaId, chapterId);

  /// Persists the current page. The chapter is flagged read once the last page
  /// is reached; earlier pages never clear an existing read flag.
  Future<void> updatePage(
    int chapterId,
    int pageIndex, {
    required int pageCount,
  }) {
    final reachedEnd = pageCount > 0 && pageIndex >= pageCount - 1;
    return _db.chapterDao
        .updateProgress(chapterId, pageIndex, isRead: reachedEnd ? true : null);
  }

  Future<void> markRead(int chapterId, {required int lastPageIndex}) =>
      _db.chapterDao.updateProgress(chapterId, lastPageIndex, isRead: true);

  /// Clears the read flag and forgets the page position for a chapter.
  Future<void> markUnread(int chapterId) =>
      _db.chapterDao.clearProgress(chapterId);
}
