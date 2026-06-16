import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/models/reference.dart';
import 'package:mango/data/repositories/manga_repository.dart';

const _v1 = '''
[
  {
    "title": "Witch Hat Atelier",
    "identifier": "witch-hat-atelier",
    "thumbnail": "https://example.com/t.webp",
    "chapters": [
      { "id": "1", "order": 1, "pages": ["a1.jpg", "a2.jpg"] }
    ]
  }
]
''';

// Same identifier: updated title, a changed page URL, plus a new chapter.
const _v2 = '''
[
  {
    "title": "Witch Hat Atelier (v2)",
    "identifier": "witch-hat-atelier",
    "thumbnail": "https://example.com/t2.webp",
    "chapters": [
      { "id": "1", "order": 1, "pages": ["a1.jpg", "a2-new.jpg"] },
      { "id": "2", "order": 2, "pages": ["b1.jpg"] }
    ]
  }
]
''';

void main() {
  late AppDatabase db;
  late MangaRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = MangaRepository(db);
  });
  tearDown(() => db.close());

  test('new import inserts manga, chapter and pages', () async {
    final result = await repo.import(parseReferenceJson(_v1));
    expect(result.added, 1);
    expect(result.updated, 0);

    final manga = await db.mangaDao.getAllManga();
    expect(manga.single.title, 'Witch Hat Atelier');

    final chapters =
        await db.chapterDao.getChaptersForManga('witch-hat-atelier');
    expect(chapters, hasLength(1));
    expect(await db.pageDao.getPagesForChapter(chapters.single.id), hasLength(2));
  });

  test('re-import updates metadata and preserves favorite + progress',
      () async {
    await repo.import(parseReferenceJson(_v1));

    // User favorites the manga and reads to page 1 of chapter 1.
    await db.mangaDao.setFavorite('witch-hat-atelier', true, favoriteOrder: 0);
    final ch1 =
        (await db.chapterDao.getChaptersForManga('witch-hat-atelier')).single;
    await db.chapterDao.updateProgress(ch1.id, 1, isRead: true);

    // Mark the local file for the unchanged page to test preservation.
    final pages = await db.pageDao.getPagesForChapter(ch1.id);
    final unchanged = pages.firstWhere((p) => p.url == 'a1.jpg');
    await db.pageDao.setLocalPath(unchanged.id, '/local/a1.jpg');

    final result = await repo.import(parseReferenceJson(_v2));
    expect(result.added, 0);
    expect(result.updated, 1);

    final manga = await db.mangaDao.getByIdentifier('witch-hat-atelier');
    expect(manga!.title, 'Witch Hat Atelier (v2)');
    expect(manga.thumbnail, 'https://example.com/t2.webp');
    expect(manga.isFavorite, isTrue, reason: 'favorite must survive update');
    expect(manga.favoriteOrder, 0);

    final chapters =
        await db.chapterDao.getChaptersForManga('witch-hat-atelier');
    expect(chapters, hasLength(2), reason: 'new chapter added');

    final updatedCh1 = chapters.firstWhere((c) => c.sourceChapterId == '1');
    expect(updatedCh1.lastPageRead, 1, reason: 'progress preserved');
    expect(updatedCh1.isRead, isTrue);

    final newPages = await db.pageDao.getPagesForChapter(updatedCh1.id);
    final keptLocal = newPages.firstWhere((p) => p.url == 'a1.jpg');
    expect(keptLocal.localPath, '/local/a1.jpg',
        reason: 'local file kept where URL unchanged');
    final changed = newPages.firstWhere((p) => p.url == 'a2-new.jpg');
    expect(changed.localPath, isNull,
        reason: 'local file cleared where URL changed');
  });
}
