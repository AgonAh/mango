import 'package:flutter_test/flutter_test.dart';
import 'package:mango/features/library/library_entry.dart';
import 'package:mango/features/library/library_sort.dart';

LibraryEntry _entry(
  String id, {
  bool favorite = false,
  int? favoriteOrder,
  DateTime? lastReadAt,
}) {
  return LibraryEntry(
    kind: LibraryKind.manga,
    title: id,
    isFavorite: favorite,
    favoriteOrder: favoriteOrder,
    lastReadAt: lastReadAt,
    mangaId: id,
  );
}

void main() {
  test('favorites come first, ordered by favoriteOrder', () {
    final groups = groupLibrary([
      _entry('b-fav', favorite: true, favoriteOrder: 1),
      _entry('a-fav', favorite: true, favoriteOrder: 0),
      _entry('plain'),
    ]);

    expect(groups.favorites.map((m) => m.title), ['a-fav', 'b-fav']);
    expect(groups.others.map((m) => m.title), ['plain']);
  });

  test('started series sort above unstarted, by recency', () {
    final groups = groupLibrary([
      _entry('zeta'),
      _entry('alpha'),
      _entry('older', lastReadAt: DateTime(2026, 1, 1)),
      _entry('newer', lastReadAt: DateTime(2026, 6, 1)),
    ]);

    expect(
      groups.others.map((m) => m.title),
      ['newer', 'older', 'alpha', 'zeta'],
    );
  });

  test('a favorited started series stays in favorites, not the started group',
      () {
    final groups = groupLibrary([
      _entry('fav', favorite: true, favoriteOrder: 0, lastReadAt: DateTime(2026)),
      _entry('started', lastReadAt: DateTime(2026)),
    ]);

    expect(groups.favorites.map((m) => m.title), ['fav']);
    expect(groups.others.map((m) => m.title), ['started']);
  });
}
