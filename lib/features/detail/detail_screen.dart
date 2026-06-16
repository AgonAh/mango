import 'package:cached_network_image/cached_network_image.dart'
    hide DownloadProgress;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router.dart';
import '../../data/db/database.dart';
import '../../data/services/download_manager.dart';
import '../../shared/providers.dart';
import '../reader/reader_screen.dart';

/// Manga detail: cover + read count, a resume/start button, and the chapter
/// list with read and partial-progress indicators.
class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.identifier});

  final String identifier;

  void _openReader(
    BuildContext context,
    ChapterRow chapter, {
    int? initialPage,
  }) {
    Navigator.of(context).pushNamed(
      Routes.reader,
      arguments: ReaderArgs(
        mangaId: identifier,
        chapterId: chapter.id,
        chapterLabel: 'Chapter ${chapter.sortOrder}',
        pageCount: chapter.pageCount,
        initialPage: initialPage ?? chapter.lastPageRead ?? 0,
      ),
    );
  }

  void _showChapterMenu(BuildContext context, WidgetRef ref, ChapterRow c) {
    final progress = ref.read(progressRepositoryProvider);
    final manager = ref.read(downloadManagerProvider.notifier);
    final isDownloading = ref.read(downloadManagerProvider).tasks.containsKey(c.id);

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Chapter ${c.sortOrder}',
                style: Theme.of(sheetContext).textTheme.titleMedium,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Mark as read'),
              onTap: () {
                progress.markRead(
                  c.id,
                  lastPageIndex: c.pageCount > 0 ? c.pageCount - 1 : 0,
                );
                Navigator.of(sheetContext).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle_outline),
              title: const Text('Mark as unread'),
              subtitle: const Text('Clears read mark and page progress'),
              onTap: () {
                progress.markUnread(c.id);
                Navigator.of(sheetContext).pop();
              },
            ),
            const Divider(height: 1),
            if (isDownloading)
              ListTile(
                leading: const Icon(Icons.cancel_outlined),
                title: const Text('Cancel download'),
                onTap: () {
                  manager.cancel(c.id);
                  Navigator.of(sheetContext).pop();
                },
              )
            else if (c.isDownloaded)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remove download'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _confirmRemoveChapter(context, ref, c);
                },
              )
            else
              ListTile(
                leading: const Icon(Icons.download_outlined),
                title: const Text('Download chapter'),
                onTap: () {
                  manager.enqueueChapter(c);
                  Navigator.of(sheetContext).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSpeedDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (_) => Consumer(
        builder: (dialogContext, dialogRef, __) {
          final pace = dialogRef.watch(downloadManagerProvider).paceMs;
          return AlertDialog(
            title: const Text('Download speed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_paceLabel(pace),
                    style: Theme.of(dialogContext).textTheme.titleMedium),
                Slider(
                  value: pace.toDouble(),
                  min: kPaceMinMs.toDouble(),
                  max: kPaceMaxMs.toDouble(),
                  divisions: (kPaceMaxMs - kPaceMinMs) ~/ 500,
                  label: _paceLabel(pace),
                  onChanged: (v) => dialogRef
                      .read(downloadManagerProvider.notifier)
                      .setPace(v.round()),
                ),
                const Text(
                  'Slower is gentler on the source server.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmRemoveChapter(
    BuildContext context,
    WidgetRef ref,
    ChapterRow c,
  ) async {
    final ok = await _confirm(
      context,
      'Remove download?',
      'Delete the downloaded pages for Chapter ${c.sortOrder}?',
    );
    if (ok) ref.read(downloadRepositoryProvider).undownloadChapter(c.id);
  }

  Future<void> _confirmRemoveAll(BuildContext context, WidgetRef ref) async {
    final ok = await _confirm(
      context,
      'Remove all downloads?',
      'Delete all downloaded pages for this manga?',
    );
    if (ok) ref.read(downloadRepositoryProvider).undownloadManga(identifier);
  }

  Future<bool> _confirm(
    BuildContext context,
    String title,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  String _paceLabel(int ms) {
    if (ms <= 1000) {
      final perSec = 1000 / ms;
      final text = perSec % 1 == 0
          ? perSec.toStringAsFixed(0)
          : perSec.toStringAsFixed(1);
      return '$text files / sec';
    }
    final secs = ms / 1000;
    final text = secs % 1 == 0 ? secs.toStringAsFixed(0) : secs.toStringAsFixed(1);
    return '1 file / ${text}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaAsync = ref.watch(mangaDetailProvider(identifier));
    final chaptersAsync = ref.watch(chaptersProvider(identifier));
    final downloads = ref.watch(downloadManagerProvider);

    final manga = mangaAsync.value;
    final chapters = chaptersAsync.value ?? const <ChapterRow>[];

    final readCount = chapters.where((c) => c.isRead).length;

    // Resume target: the manga's last-opened chapter if still present,
    // otherwise the first chapter.
    final resumeChapter = manga?.lastReadChapterId == null
        ? null
        : chapters.firstWhereOrNull((c) => c.id == manga!.lastReadChapterId);
    final startTarget = resumeChapter ?? chapters.firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(manga?.title ?? identifier),
        actions: [
          if (manga != null)
            IconButton(
              icon: Icon(manga.isFavorite ? Icons.star : Icons.star_border),
              color: manga.isFavorite
                  ? Theme.of(context).colorScheme.primary
                  : null,
              onPressed: () =>
                  ref.read(mangaRepositoryProvider).toggleFavorite(manga),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              final manager = ref.read(downloadManagerProvider.notifier);
              switch (value) {
                case 'dl_all':
                  manager.enqueueManga(identifier);
                case 'cancel_all':
                  manager.cancelAll();
                case 'rm_all':
                  _confirmRemoveAll(context, ref);
                case 'speed':
                  _showSpeedDialog(context, ref);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'dl_all',
                child: Text('Download all chapters'),
              ),
              if (downloads.tasks.isNotEmpty)
                const PopupMenuItem(
                  value: 'cancel_all',
                  child: Text('Cancel all downloads'),
                ),
              const PopupMenuItem(
                value: 'rm_all',
                child: Text('Remove all downloads'),
              ),
              const PopupMenuItem(
                value: 'speed',
                child: Text('Download speed…'),
              ),
            ],
          ),
        ],
      ),
      body: chaptersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              manga: manga,
              identifier: identifier,
              readCount: readCount,
              totalCount: chapters.length,
            ),
            if (startTarget != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: FilledButton.icon(
                  icon: Icon(resumeChapter != null
                      ? Icons.play_arrow
                      : Icons.menu_book),
                  label: Text(
                    resumeChapter != null
                        ? 'Continue · Chapter ${resumeChapter.sortOrder}'
                        : 'Start reading',
                  ),
                  onPressed: () => _openReader(context, startTarget),
                ),
              ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: chapters.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final c = chapters[i];
                  return _ChapterTile(
                    chapter: c,
                    download: downloads.tasks[c.id],
                    onTap: () => _openReader(context, c),
                    onLongPress: () => _showChapterMenu(context, ref, c),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.manga,
    required this.identifier,
    required this.readCount,
    required this.totalCount,
  });

  final MangaRow? manga;
  final String identifier;
  final int readCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: manga?.thumbnail ?? '',
              width: 96,
              height: 134,
              fit: BoxFit.cover,
              placeholder: (_, __) => const ColoredBox(color: Colors.black26),
              errorWidget: (_, __, ___) => const ColoredBox(
                color: Colors.black26,
                child: Icon(Icons.broken_image, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  manga?.title ?? identifier,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  '$readCount of $totalCount chapters read',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChapterTile extends StatelessWidget {
  const _ChapterTile({
    required this.chapter,
    required this.download,
    required this.onTap,
    required this.onLongPress,
  });

  final ChapterRow chapter;
  final DownloadProgress? download;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final partiallyRead = !chapter.isRead &&
        chapter.lastPageRead != null &&
        chapter.lastPageRead! > 0;
    final primary = Theme.of(context).colorScheme.primary;

    final readIcon = chapter.isRead
        ? Icon(Icons.check_circle, color: primary)
        : (partiallyRead
            ? const Icon(Icons.history)
            : const Icon(Icons.circle_outlined, color: Colors.white24));

    return ListTile(
      onTap: onTap,
      onLongPress: onLongPress,
      title: Text('Chapter ${chapter.sortOrder}'),
      subtitle: Text(
        partiallyRead
            ? 'Page ${chapter.lastPageRead! + 1} of ${chapter.pageCount}'
            : '${chapter.pageCount} pages',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _downloadIndicator(primary),
          readIcon,
        ],
      ),
    );
  }

  Widget _downloadIndicator(Color primary) {
    final task = download;
    if (task != null && task.status != DownloadStatus.completed) {
      final failed = task.status == DownloadStatus.failed;
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: failed
            ? const Icon(Icons.error_outline, color: Colors.redAccent, size: 20)
            : SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: task.total > 0 ? task.fraction : null,
                ),
              ),
      );
    }
    if (chapter.isDownloaded) {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Icon(Icons.download_done, color: primary, size: 20),
      );
    }
    return const SizedBox.shrink();
  }
}
