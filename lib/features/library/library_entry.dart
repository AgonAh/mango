import '../../data/db/database.dart';

enum LibraryKind { manga, book }

/// A unified view-model for the library grid — either a manga or a book — with
/// the common fields used for display, favorites, and sorting.
class LibraryEntry {
  const LibraryEntry({
    required this.kind,
    required this.title,
    required this.isFavorite,
    required this.favoriteOrder,
    required this.lastReadAt,
    this.mangaId,
    this.bookId,
    this.coverUrl,
    this.coverPath,
    this.badge,
  });

  final LibraryKind kind;
  final String title;
  final bool isFavorite;
  final int? favoriteOrder;
  final DateTime? lastReadAt;

  final String? mangaId; // manga identifier
  final int? bookId; // book id
  final String? coverUrl; // manga thumbnail (network)
  final String? coverPath; // book cover (local file)
  final String? badge; // 'PDF' | 'EPUB' for books

  factory LibraryEntry.manga(MangaRow m) => LibraryEntry(
        kind: LibraryKind.manga,
        title: m.title,
        isFavorite: m.isFavorite,
        favoriteOrder: m.favoriteOrder,
        lastReadAt: m.lastReadAt,
        mangaId: m.identifier,
        coverUrl: m.thumbnail,
      );

  factory LibraryEntry.book(BookRow b) => LibraryEntry(
        kind: LibraryKind.book,
        title: b.title,
        isFavorite: b.isFavorite,
        favoriteOrder: b.favoriteOrder,
        lastReadAt: b.lastReadAt,
        bookId: b.id,
        coverPath: b.coverPath,
        coverUrl: b.coverUrl,
        badge: b.type.toUpperCase(),
      );
}
