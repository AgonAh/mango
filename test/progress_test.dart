import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/db/tables.dart';
import 'package:mango/data/repositories/progress_repository.dart';

void main() {
  late AppDatabase db;
  late ProgressRepository progress;
  late int chapterId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    progress = ProgressRepository(db);
    await db.mangaDao.upsertManga(
      MangaTableCompanion.insert(identifier: 'm', title: 'M', thumbnail: 't'),
    );
    chapterId = await db.chapterDao.insertChapter(
      ChapterTableCompanion.insert(
        mangaId: 'm',
        sourceChapterId: '1',
        sortOrder: 1,
        pageCount: const Value(10),
      ),
    );
  });
  tearDown(() => db.close());

  test('opening a chapter sets resume target and marks started', () async {
    await progress.openChapter('m', chapterId);
    final manga = await db.mangaDao.getByIdentifier('m');
    expect(manga!.lastReadChapterId, chapterId);
    expect(manga.lastReadAt, isNotNull);
  });

  test('mid-chapter page does not mark read; last page does', () async {
    await progress.updatePage(chapterId, 4, pageCount: 10);
    var c = await db.chapterDao.getById(chapterId);
    expect(c!.lastPageRead, 4);
    expect(c.isRead, isFalse);

    await progress.updatePage(chapterId, 9, pageCount: 10);
    c = await db.chapterDao.getById(chapterId);
    expect(c!.lastPageRead, 9);
    expect(c.isRead, isTrue);
  });

  test('markUnread clears read flag and page position', () async {
    await progress.markRead(chapterId, lastPageIndex: 9);
    await progress.markUnread(chapterId);

    final c = await db.chapterDao.getById(chapterId);
    expect(c!.isRead, isFalse);
    expect(c.lastPageRead, isNull);
    expect(c.readUpdatedAt, isNull);
  });

  test('read flag is not cleared by re-reading earlier pages', () async {
    await progress.markRead(chapterId, lastPageIndex: 9);
    await progress.updatePage(chapterId, 2, pageCount: 10);
    final c = await db.chapterDao.getById(chapterId);
    expect(c!.isRead, isTrue, reason: 'earlier page must not unset read');
    expect(c.lastPageRead, 2);
  });
}
