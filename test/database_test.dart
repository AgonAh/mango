import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/db/tables.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('round-trips manga, chapter and pages', () async {
    await db.mangaDao.upsertManga(
      MangaTableCompanion.insert(
        identifier: 'witch-hat-atelier',
        title: 'Witch Hat Atelier',
        thumbnail: 'https://example.com/thumb.webp',
      ),
    );

    final chapterId = await db.chapterDao.insertChapter(
      ChapterTableCompanion.insert(
        mangaId: 'witch-hat-atelier',
        sourceChapterId: '1',
        sortOrder: 1,
        pageCount: const Value(2),
      ),
    );

    await db.pageDao.insertPages([
      PageTableCompanion.insert(
          chapterId: chapterId, pageIndex: 0, url: 'a.jpg'),
      PageTableCompanion.insert(
          chapterId: chapterId, pageIndex: 1, url: 'b.jpg'),
    ]);

    expect(await db.mangaDao.getAllManga(), hasLength(1));

    final chapters =
        await db.chapterDao.getChaptersForManga('witch-hat-atelier');
    expect(chapters, hasLength(1));
    expect(chapters.single.sortOrder, 1);

    final pages = await db.pageDao.getPagesForChapter(chapterId);
    expect(pages, hasLength(2));
    expect(pages.first.pageIndex, 0);
  });

  test('upsert updates by identifier rather than duplicating', () async {
    final companion = MangaTableCompanion.insert(
      identifier: 'dupe',
      title: 'First',
      thumbnail: 't1',
    );
    await db.mangaDao.upsertManga(companion);
    await db.mangaDao.upsertManga(
      companion.copyWith(title: const Value('Second')),
    );

    final all = await db.mangaDao.getAllManga();
    expect(all, hasLength(1));
    expect(all.single.title, 'Second');
  });

  test('tracks reading progress and read count', () async {
    await db.mangaDao.upsertManga(
      MangaTableCompanion.insert(
        identifier: 'm',
        title: 'M',
        thumbnail: 't',
      ),
    );
    final c1 = await db.chapterDao.insertChapter(
      ChapterTableCompanion.insert(
          mangaId: 'm', sourceChapterId: '1', sortOrder: 1),
    );
    await db.chapterDao.insertChapter(
      ChapterTableCompanion.insert(
          mangaId: 'm', sourceChapterId: '2', sortOrder: 2),
    );

    await db.chapterDao.updateProgress(c1, 5, isRead: true);

    final chapter = await db.chapterDao.getById(c1);
    expect(chapter!.lastPageRead, 5);
    expect(chapter.isRead, isTrue);
    expect(await db.chapterDao.readChapterCount('m'), 1);
  });
}
