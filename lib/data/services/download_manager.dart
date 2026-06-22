import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/database.dart';
import '../../shared/chapter_format.dart';
import '../../shared/providers.dart';

/// Pace bounds (delay between successive file downloads), per the requirement
/// to avoid hammering the source server.
const int kPaceDefaultMs = 1000; // 1 file / second
const int kPaceMinMs = 500; // fastest: 2 files / second
const int kPaceMaxMs = 5000; // slowest: 1 file / 5 seconds

int clampPaceMs(int ms) => ms.clamp(kPaceMinMs, kPaceMaxMs);

enum DownloadStatus { queued, downloading, completed, failed, canceled }

class DownloadProgress {
  const DownloadProgress({
    required this.chapterId,
    required this.label,
    required this.total,
    required this.completed,
    required this.status,
  });

  final int chapterId;
  final String label;
  final int total;
  final int completed;
  final DownloadStatus status;

  double get fraction => total == 0 ? 0 : completed / total;

  DownloadProgress copyWith({
    int? total,
    int? completed,
    DownloadStatus? status,
  }) =>
      DownloadProgress(
        chapterId: chapterId,
        label: label,
        total: total ?? this.total,
        completed: completed ?? this.completed,
        status: status ?? this.status,
      );
}

class DownloadState {
  const DownloadState({
    this.tasks = const {},
    this.paused = false,
    this.paceMs = kPaceDefaultMs,
  });

  /// Active/queued downloads keyed by chapter id. Completed chapters are
  /// removed (their persistent state lives on the chapter's `isDownloaded`).
  final Map<int, DownloadProgress> tasks;
  final bool paused;
  final int paceMs;

  DownloadState copyWith({
    Map<int, DownloadProgress>? tasks,
    bool? paused,
    int? paceMs,
  }) =>
      DownloadState(
        tasks: tasks ?? this.tasks,
        paused: paused ?? this.paused,
        paceMs: paceMs ?? this.paceMs,
      );
}

/// Rate-limited, single-worker download queue. Enqueue whole chapters (a
/// whole-manga download just enqueues all of them); pages download one at a
/// time with a configurable minimum gap between requests.
class DownloadManager extends Notifier<DownloadState> {
  final List<int> _queue = [];
  final Set<int> _canceled = {};
  bool _working = false;

  /// Chapter currently being downloaded (a page may be in-flight). Cleanup for
  /// this chapter is deferred to the worker to avoid deleting a file mid-write.
  int? _active;

  @override
  DownloadState build() {
    // Seed the pace from persisted settings.
    final pace = clampPaceMs(ref.read(settingsServiceProvider).paceMs);
    return DownloadState(paceMs: pace);
  }

  void setPace(int ms) {
    final clamped = clampPaceMs(ms);
    state = state.copyWith(paceMs: clamped);
    ref.read(settingsServiceProvider).setPaceMs(clamped);
  }

  void pause() => state = state.copyWith(paused: true);

  void resume() {
    state = state.copyWith(paused: false);
    _ensureWorker();
  }

  Future<void> enqueueChapter(ChapterRow chapter) async {
    final pages =
        await ref.read(databaseProvider).pageDao.getPagesForChapter(chapter.id);
    final done = pages.where((p) => p.localPath != null).length;
    _canceled.remove(chapter.id);
    _putTask(DownloadProgress(
      chapterId: chapter.id,
      label: chapterName(chapter),
      total: pages.length,
      completed: done,
      status: DownloadStatus.queued,
    ));
    if (!_queue.contains(chapter.id)) _queue.add(chapter.id);
    _ensureWorker();
  }

  Future<void> enqueueManga(String mangaId) async {
    final chapters = await ref
        .read(databaseProvider)
        .chapterDao
        .getChaptersForManga(mangaId);
    await enqueueChapters(chapters);
  }

  Future<void> enqueueChapters(List<ChapterRow> chapters) async {
    for (final chapter in chapters) {
      await enqueueChapter(chapter);
    }
  }

  void cancel(int chapterId) {
    _queue.remove(chapterId);
    _canceled.add(chapterId);
    _removeTask(chapterId);
    // If the chapter isn't the one currently in-flight, delete its partial
    // files now. Otherwise the worker cleans up when it notices the flag.
    if (chapterId != _active) {
      _cleanupCanceled(chapterId);
    }
  }

  /// Cancels every queued/active download. Already-completed chapters have no
  /// task, so they are untouched and stay downloaded.
  void cancelAll() {
    final ids = {...state.tasks.keys, ..._queue};
    _queue.clear();
    _canceled.addAll(ids);
    state = state.copyWith(tasks: const {});
    for (final id in ids) {
      if (id != _active) _cleanupCanceled(id);
    }
  }

  Future<void> _cleanupCanceled(int chapterId) async {
    _removeTask(chapterId);
    await ref.read(downloadRepositoryProvider).undownloadChapter(chapterId);
  }

  void _putTask(DownloadProgress progress) {
    state = state.copyWith(tasks: {...state.tasks, progress.chapterId: progress});
  }

  void _removeTask(int chapterId) {
    state = state.copyWith(tasks: {...state.tasks}..remove(chapterId));
  }

  void _updateTask(int chapterId, {int? completed, DownloadStatus? status}) {
    final task = state.tasks[chapterId];
    if (task == null) return;
    _putTask(task.copyWith(completed: completed, status: status));
  }

  void _ensureWorker() {
    if (!_working && !state.paused) {
      _working = true;
      _work();
    }
  }

  Future<void> _work() async {
    try {
      while (_queue.isNotEmpty && !state.paused) {
        final chapterId = _queue.first;
        if (_canceled.contains(chapterId)) {
          _queue.removeAt(0);
          continue;
        }
        final finished = await _processChapter(chapterId);
        // Only dequeue when fully done; a pause leaves it in place to resume.
        if (finished) _queue.remove(chapterId);
        if (!finished) break;
      }
    } finally {
      _working = false;
    }
  }

  /// Returns true when the chapter is fully handled (completed, failed, or
  /// canceled); false if it was interrupted by a pause and should resume.
  Future<bool> _processChapter(int chapterId) async {
    _active = chapterId;
    try {
      final db = ref.read(databaseProvider);
      final repo = ref.read(downloadRepositoryProvider);
      final chapter = await db.chapterDao.getById(chapterId);
      if (chapter == null) return true;

      final pages = await db.pageDao.getPagesForChapter(chapterId);
      _updateTask(chapterId, status: DownloadStatus.downloading);
      var completed = pages.where((p) => p.localPath != null).length;

      for (final page in pages) {
        if (_canceled.contains(chapterId)) {
          await _cleanupCanceled(chapterId);
          return true;
        }
        if (state.paused) return false;

        final alreadyLocal =
            page.localPath != null && File(page.localPath!).existsSync();
        if (!alreadyLocal) {
          await Future.delayed(Duration(milliseconds: state.paceMs));
          if (_canceled.contains(chapterId)) {
            await _cleanupCanceled(chapterId);
            return true;
          }
          try {
            await repo.downloadPage(
              page,
              mangaId: chapter.mangaId,
              sourceChapterId: chapter.sourceChapterId,
            );
          } catch (_) {
            _updateTask(chapterId, status: DownloadStatus.failed);
            return true;
          }
          completed++;
          _updateTask(chapterId, completed: completed);
        }
      }

      await db.chapterDao.updateChapter(
        chapterId,
        const ChapterTableCompanion(isDownloaded: Value(true)),
      );
      _removeTask(chapterId);
      return true;
    } finally {
      _active = null;
    }
  }
}
