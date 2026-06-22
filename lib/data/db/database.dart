import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/chapter_dao.dart';
import 'daos/favorite_page_dao.dart';
import 'daos/manga_dao.dart';
import 'daos/page_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [MangaTable, ChapterTable, PageTable, FavoritePageTable],
  daos: [MangaDao, ChapterDao, PageDao, FavoritePageDao],
)
class AppDatabase extends _$AppDatabase {
  /// Production constructor opens the on-device SQLite file. Pass a
  /// [QueryExecutor] (e.g. `NativeDatabase.memory()`) for tests.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // v2: chapter titles, per-manga reading direction, favorite pages.
            await m.addColumn(chapterTable, chapterTable.title);
            await m.addColumn(mangaTable, mangaTable.readingDirection);
            await m.createTable(favoritePageTable);
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
