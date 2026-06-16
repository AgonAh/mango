import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/data/db/tables.dart';
import 'package:mango/data/repositories/manga_repository.dart';

void main() {
  late AppDatabase db;
  late MangaRepository repo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = MangaRepository(db);
    for (final id in ['a', 'b', 'c']) {
      await db.mangaDao
          .upsertManga(MangaTableCompanion.insert(
        identifier: id,
        title: id.toUpperCase(),
        thumbnail: 't',
      ));
      await db.mangaDao.setFavorite(id, true, favoriteOrder: 0);
    }
  });
  tearDown(() => db.close());

  test('reorderFavorites assigns sequential favoriteOrder by position',
      () async {
    await repo.reorderFavorites(['c', 'a', 'b']);

    final c = await db.mangaDao.getByIdentifier('c');
    final a = await db.mangaDao.getByIdentifier('a');
    final b = await db.mangaDao.getByIdentifier('b');

    expect(c!.favoriteOrder, 0);
    expect(a!.favoriteOrder, 1);
    expect(b!.favoriteOrder, 2);
  });

  test('toggleFavorite appends to the end then clears on unfavorite', () async {
    await db.mangaDao.upsertManga(MangaTableCompanion.insert(
      identifier: 'd',
      title: 'D',
      thumbnail: 't',
    ));
    final d = await db.mangaDao.getByIdentifier('d');

    await repo.reorderFavorites(['a', 'b', 'c']); // orders 0,1,2
    await repo.toggleFavorite(d!); // should become order 3

    final favored = await db.mangaDao.getByIdentifier('d');
    expect(favored!.isFavorite, isTrue);
    expect(favored.favoriteOrder, 3);

    await repo.toggleFavorite(favored);
    final unfavored = await db.mangaDao.getByIdentifier('d');
    expect(unfavored!.isFavorite, isFalse);
    expect(unfavored.favoriteOrder, isNull);
  });
}
