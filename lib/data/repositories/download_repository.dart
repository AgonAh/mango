import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../db/database.dart';

/// Handles the filesystem side of downloads: writing page images to
/// app-private storage, and removing them again. Files live under
/// `<app-documents>/manga/<identifier>/<chapter>/<index>.<ext>` so nothing
/// leaks into the user's gallery.
class DownloadRepository {
  DownloadRepository(this._db, this._dio);

  final AppDatabase _db;
  final Dio _dio;

  Future<Directory> _chapterDir(String mangaId, String sourceChapterId) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(
      p.join(docs.path, 'manga', _safe(mangaId), _safe(sourceChapterId)),
    );
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  String _safe(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');

  String _ext(String url) {
    final ext = p.extension(Uri.parse(url).path);
    return ext.isEmpty ? '.jpg' : ext;
  }

  /// Downloads a single page to local storage and records its path. No-op if
  /// the file already exists (so an interrupted download resumes cleanly).
  Future<void> downloadPage(
    PageRow page, {
    required String mangaId,
    required String sourceChapterId,
  }) async {
    final dir = await _chapterDir(mangaId, sourceChapterId);
    final file = File(p.join(dir.path, '${page.pageIndex}${_ext(page.url)}'));
    if (file.existsSync()) {
      if (page.localPath != file.path) {
        await _db.pageDao.setLocalPath(page.id, file.path);
      }
      return;
    }
    await _dio.download(page.url, file.path);
    await _db.pageDao.setLocalPath(page.id, file.path);
  }

  Future<void> undownloadChapter(int chapterId) async {
    final pages = await _db.pageDao.getPagesForChapter(chapterId);
    for (final page in pages) {
      final local = page.localPath;
      if (local != null) {
        final file = File(local);
        if (file.existsSync()) {
          try {
            file.deleteSync();
          } catch (_) {
            // Ignore: a missing/locked file shouldn't block clearing state.
          }
        }
      }
    }
    await _db.pageDao.clearLocalPaths(chapterId);
    await _db.chapterDao.updateChapter(
      chapterId,
      const ChapterTableCompanion(isDownloaded: Value(false)),
    );
  }

  Future<void> undownloadManga(String mangaId) async {
    final chapters = await _db.chapterDao.getChaptersForManga(mangaId);
    for (final chapter in chapters) {
      await undownloadChapter(chapter.id);
    }
  }
}
