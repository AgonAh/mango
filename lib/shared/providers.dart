/// Top-level Riverpod providers shared across features.
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/database.dart';
import '../data/repositories/download_repository.dart';
import '../data/repositories/manga_repository.dart';
import '../data/repositories/progress_repository.dart';
import '../data/services/download_manager.dart';
import '../data/services/json_import_service.dart';
import '../data/services/settings_service.dart';

/// Single app-wide database instance. Disposed with the provider scope.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Persisted app settings. Overridden in `main` with the loaded instance.
final settingsServiceProvider = Provider<SettingsService>(
  (ref) => throw UnimplementedError('settingsServiceProvider must be overridden'),
);

/// HTTP client used for JSON fetches and (later) page downloads.
final dioProvider = Provider<Dio>((ref) => Dio());

final jsonImportServiceProvider = Provider<JsonImportService>(
  (ref) => JsonImportService(ref.watch(dioProvider)),
);

final mangaRepositoryProvider = Provider<MangaRepository>(
  (ref) => MangaRepository(ref.watch(databaseProvider)),
);

final progressRepositoryProvider = Provider<ProgressRepository>(
  (ref) => ProgressRepository(ref.watch(databaseProvider)),
);

final downloadRepositoryProvider = Provider<DownloadRepository>(
  (ref) => DownloadRepository(
    ref.watch(databaseProvider),
    ref.watch(dioProvider),
  ),
);

/// App-wide download queue + progress state.
final downloadManagerProvider =
    NotifierProvider<DownloadManager, DownloadState>(DownloadManager.new);

/// Reactive library list backed by the database.
final mangaListProvider = StreamProvider<List<MangaRow>>(
  (ref) => ref.watch(mangaRepositoryProvider).watchLibrary(),
);

/// A single manga (by identifier), kept live for the detail screen.
final mangaDetailProvider = StreamProvider.family<MangaRow?, String>(
  (ref, identifier) =>
      ref.watch(databaseProvider).mangaDao.watchByIdentifier(identifier),
);

/// Ordered chapters for a manga, kept live so read state updates reactively.
final chaptersProvider = StreamProvider.family<List<ChapterRow>, String>(
  (ref, identifier) =>
      ref.watch(databaseProvider).chapterDao.watchChaptersForManga(identifier),
);
