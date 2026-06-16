import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/db/database.dart';
import 'package:mango/features/library/library_sort.dart';

MangaRow _manga(
  String id, {
  bool favorite = false,
  int? favoriteOrder,
  DateTime? lastReadAt,
}) {
  final now = DateTime(2026);
  return MangaRow(
    identifier: id,
    title: id,
    thumbnail: 't',
    isFavorite: favorite,
    favoriteOrder: favoriteOrder,
    lastReadChapterId: null,
    lastReadAt: lastReadAt,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  test('favorites come first, ordered by favoriteOrder', () {
    final groups = groupLibrary([
      _manga('b-fav', favorite: true, favoriteOrder: 1),
      _manga('a-fav', favorite: true, favoriteOrder: 0),
      _manga('plain'),
    ]);

    expect(groups.favorites.map((m) => m.identifier), ['a-fav', 'b-fav']);
    expect(groups.others.map((m) => m.identifier), ['plain']);
  });

  test('started series sort above unstarted, by recency', () {
    final groups = groupLibrary([
      _manga('zeta'), // unstarted, alphabetical last
      _manga('alpha'), // unstarted
      _manga('older', lastReadAt: DateTime(2026, 1, 1)),
      _manga('newer', lastReadAt: DateTime(2026, 6, 1)),
    ]);

    expect(
      groups.others.map((m) => m.identifier),
      ['newer', 'older', 'alpha', 'zeta'],
    );
  });

  test('a favorited started series stays in favorites, not the started group',
      () {
    final groups = groupLibrary([
      _manga('fav', favorite: true, favoriteOrder: 0, lastReadAt: DateTime(2026)),
      _manga('started', lastReadAt: DateTime(2026)),
    ]);

    expect(groups.favorites.map((m) => m.identifier), ['fav']);
    expect(groups.others.map((m) => m.identifier), ['started']);
  });
}
