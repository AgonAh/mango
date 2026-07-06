import 'library_entry.dart';

/// The library split into its two visual sections.
typedef LibraryGroups = ({List<LibraryEntry> favorites, List<LibraryEntry> others});

/// Applies the library ordering rules:
///
/// * Favorites come first, in their manual [LibraryEntry.favoriteOrder]
///   (entries without an order fall back to alphabetical).
/// * Everything else: anything started (has a [LibraryEntry.lastReadAt]) sorts
///   to the top by most-recently-read, then the remainder alphabetically.
LibraryGroups groupLibrary(List<LibraryEntry> all) {
  final favorites = all.where((m) => m.isFavorite).toList()
    ..sort(_byFavoriteOrderThenTitle);

  final others = all.where((m) => !m.isFavorite).toList();
  final started = others.where((m) => m.lastReadAt != null).toList()
    ..sort((a, b) => b.lastReadAt!.compareTo(a.lastReadAt!));
  final fresh = others.where((m) => m.lastReadAt == null).toList()
    ..sort(_byTitle);

  return (favorites: favorites, others: [...started, ...fresh]);
}

int _byFavoriteOrderThenTitle(LibraryEntry a, LibraryEntry b) {
  final ao = a.favoriteOrder;
  final bo = b.favoriteOrder;
  if (ao != null && bo != null) return ao.compareTo(bo);
  if (ao != null) return -1;
  if (bo != null) return 1;
  return _byTitle(a, b);
}

int _byTitle(LibraryEntry a, LibraryEntry b) =>
    a.title.toLowerCase().compareTo(b.title.toLowerCase());
