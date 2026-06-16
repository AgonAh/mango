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
