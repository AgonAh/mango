import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/book_dao.dart';
import 'daos/chapter_dao.dart';
import 'daos/favorite_page_dao.dart';
import 'daos/manga_dao.dart';
import 'daos/page_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [MangaTable, ChapterTable, PageTable, FavoritePageTable, BookTable],
  daos: [MangaDao, ChapterDao, PageDao, FavoritePageDao, BookDao],
)
class AppDatabase extends _$AppDatabase {
  /// Production constructor opens the on-device SQLite file. Pass a
  /// [QueryExecutor] (e.g. `NativeDatabase.memory()`) for tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // Each step is tolerant so a device left in a partially-migrated
          // state (e.g. from an earlier failed upgrade) still heals.
          Future<void> step(Future<void> Function() run) async {
            try {
              await run();
            } catch (_) {
              // Already applied / already exists — safe to ignore.
            }
          }

          if (from < 2) {
            // v2: chapter titles, per-manga reading direction, favorite pages.
            await step(() => m.addColumn(chapterTable, chapterTable.title));
            await step(() => m.addColumn(mangaTable, mangaTable.readingDirection));
            await step(() => m.createTable(favoritePageTable));
          }
          if (from < 3) {
            // v3: local PDF/EPUB books. createTable uses the *current* schema,
            // so the table already includes the v4 columns below.
            await step(() => m.createTable(bookTable));
          }
          if (from == 3) {
            // v4: only needed for devices whose books table predates these
            // columns (a v3 install). A pre-v3 device got them via createTable.
            await step(() => m.addColumn(bookTable, bookTable.identifier));
            await step(() => m.addColumn(bookTable, bookTable.sourceUrl));
            await step(() => m.addColumn(bookTable, bookTable.coverUrl));
          }
        },
        beforeOpen: (details) async {
          // Enforce foreign keys so cascading deletes / integrity hold.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static LazyDatabase _open() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'mango.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
