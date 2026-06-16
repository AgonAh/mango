import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/db/tables.dart';
import 'package:mango/data/repositories/download_repository.dart';

void main() {
  late AppDatabase db;
  late DownloadRepository repo;
  late int chapterId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = DownloadRepository(db, Dio());
    await db.mangaDao.upsertManga(
      MangaTableCompanion.insert(identifier: 'm', title: 'M', thumbnail: 't'),
    );
    chapterId = await db.chapterDao.insertChapter(
      ChapterTableCompanion.insert(
        mangaId: 'm',
        sourceChapterId: '1',
        sortOrder: 1,
        pageCount: const Value(2),
        isDownloaded: const Value(true),
      ),
    );
    await db.pageDao.insertPages([
      PageTableCompanion.insert(
        chapterId: chapterId,
        pageIndex: 0,
        url: 'a.jpg',
        // Points to a non-existent file; deletion is guarded so this is fine.
        localPath: const Value('/tmp/does-not-exist/0.jpg'),
      ),
      PageTableCompanion.insert(
        chapterId: chapterId,
        pageIndex: 1,
        url: 'b.jpg',
        localPath: const Value('/tmp/does-not-exist/1.jpg'),
      ),
    ]);
  });
  tearDown(() => db.close());

  test('undownloadChapter clears local paths and the downloaded flag',
      () async {
    await repo.undownloadChapter(chapterId);

    final pages = await db.pageDao.getPagesForChapter(chapterId);
    expect(pages.every((p) => p.localPath == null), isTrue);

    final chapter = await db.chapterDao.getById(chapterId);
    expect(chapter!.isDownloaded, isFalse);
  });
}
