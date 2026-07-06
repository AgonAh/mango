import 'package:drift/drift.dart';

/// One manga series. Keyed by [identifier] (from the reference JSON), which
/// drives new-vs-update detection on import.
@DataClassName('MangaRow')
class MangaTable extends Table {
  @override
  String get tableName => 'manga';

  TextColumn get identifier => text()();
  TextColumn get title => text()();
  TextColumn get thumbnail => text()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  /// Manual sort position within favorites; null when not favorited.
  IntColumn get favoriteOrder => integer().nullable()();

  /// Resume target: surrogate id of the last-opened chapter.
  IntColumn get lastReadChapterId => integer().nullable()();

  /// Drives the "started reading sorts to top" rule.
  DateTimeColumn get lastReadAt => dateTime().nullable()();

  /// Per-manga reading direction override: 'ltr', 'rtl', or null = follow the
  /// global default.
  TextColumn get readingDirection => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {identifier};
}

/// A chapter within a manga. [sortOrder] mirrors the JSON `order` and sequences
/// next/previous navigation. ([sourceChapterId] is the JSON chapter `id`.)
@DataClassName('ChapterRow')
class ChapterTable extends Table {
  @override
  String get tableName => 'chapters';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get mangaId =>
      text().references(MangaTable, #identifier)();
  TextColumn get sourceChapterId => text()();

  /// Optional display name from the JSON; falls back to the id when absent.
  TextColumn get title => text().nullable()();
  IntColumn get sortOrder => integer()();
  IntColumn get pageCount => integer().withDefault(const Constant(0))();

  BoolColumn get isDownloaded =>
      boolean().withDefault(const Constant(false))();

  /// Resume page within the chapter (0-based); null if never opened.
  IntColumn get lastPageRead => integer().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get readUpdatedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {mangaId, sourceChapterId},
      ];
}

/// A single page image within a chapter. [localPath] is set once downloaded so
/// the reader can prefer the local file over the remote [url].
@DataClassName('PageRow')
class PageTable extends Table {
  @override
  String get tableName => 'pages';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId => integer().references(ChapterTable, #id)();
  IntColumn get pageIndex => integer()();
  TextColumn get url => text()();
  TextColumn get localPath => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {chapterId, pageIndex},
      ];
}

/// A locally-imported PDF or EPUB book. Files are copied into app-private
/// storage; [type] is 'pdf' or 'epub' and [readingMode] is 'scroll' or 'paged'.
@DataClassName('BookRow')
class BookTable extends Table {
  @override
  String get tableName => 'books';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get series => text().nullable()();
  TextColumn get type => text()(); // 'pdf' | 'epub'

  /// Stable key for JSON-imported books (null for manually added ones).
  TextColumn get identifier => text().nullable()();

  /// Local copy of the file; empty until a JSON-imported book is downloaded.
  TextColumn get filePath => text()();

  /// Remote file URL for JSON-imported books (downloaded on first read).
  TextColumn get sourceUrl => text().nullable()();
  TextColumn get coverPath => text().nullable()();

  /// Remote cover URL (JSON-imported books show this until a local cover set).
  TextColumn get coverUrl => text().nullable()();
  TextColumn get readingMode =>
      text().withDefault(const Constant('scroll'))(); // 'scroll' | 'paged'

  /// Resume position: page index for PDFs; [lastLocation] (EPUB CFI) for EPUBs.
  IntColumn get lastPage => integer().withDefault(const Constant(0))();
  TextColumn get lastLocation => text().nullable()();
  IntColumn get pageCount => integer().nullable()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get favoriteOrder => integer().nullable()();
  DateTimeColumn get lastReadAt => dateTime().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

/// A user-favorited individual page, surfaced in its own section on the manga
/// detail screen.
@DataClassName('FavoritePageRow')
class FavoritePageTable extends Table {
  @override
  String get tableName => 'favorite_pages';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get mangaId => text().references(MangaTable, #identifier)();
  IntColumn get chapterId => integer().references(ChapterTable, #id)();
  IntColumn get pageIndex => integer()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {chapterId, pageIndex},
      ];
}
