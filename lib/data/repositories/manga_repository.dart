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
    final all = await _db.mangaDao.getAllManga();
    final maxOrder = all
        .map((m) => m.favoriteOrder)
        .whereType<int>()
        .fold<int>(-1, (a, b) => a > b ? a : b);
    await _db.mangaDao
        .setFavorite(manga.identifier, true, favoriteOrder: maxOrder + 1);
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
      }
    });

    return ImportResult(added: added, updated: updated);
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
