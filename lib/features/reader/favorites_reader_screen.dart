import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    hide DownloadProgress;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';

import '../../app/router.dart';
import '../../data/db/daos/favorite_page_dao.dart';
import '../../shared/chapter_format.dart';
import '../../shared/providers.dart';
import 'reader_screen.dart';
import 'zoomable_page.dart';

class FavoritesReaderArgs {
  const FavoritesReaderArgs({
    required this.mangaId,
    required this.views,
    required this.initialIndex,
    required this.reverse,
  });

  final String mangaId;
  final List<FavoritePageView> views;
  final int initialIndex;
  final bool reverse;
}

/// Pages through a manga's favorited pages (rather than the chapter they live
/// in). Zoom and zoom-gated paging match the main reader; there are no chapter
/// transitions. A button jumps into the full chapter reader at the shown page.
class FavoritesReaderScreen extends ConsumerStatefulWidget {
  const FavoritesReaderScreen({super.key, required this.args});

  final FavoritesReaderArgs args;

  @override
  ConsumerState<FavoritesReaderScreen> createState() =>
      _FavoritesReaderScreenState();
}

class _FavoritesReaderScreenState
    extends ConsumerState<FavoritesReaderScreen> {
  late final PageController _controller;
  late int _index;
  bool _isZoomed = false;
  bool _showOverlay = false;
  int _pointerCount = 0;

  List<FavoritePageView> get _views => widget.args.views;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _index = widget.args.initialIndex.clamp(0, _views.length - 1);
    _controller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _controller.dispose();
    super.dispose();
  }

  ImageProvider _providerFor(FavoritePageView v) {
    final local = v.page.localPath;
    if (local != null && local.isNotEmpty) return FileImage(File(local));
    return CachedNetworkImageProvider(v.page.url);
  }

  void _openInChapter() {
    final v = _views[_index];
    Navigator.of(context).pushReplacementNamed(
      Routes.reader,
      arguments: ReaderArgs(
        mangaId: widget.args.mangaId,
        chapterId: v.chapter.id,
        chapterLabel: chapterName(v.chapter),
        pageCount: v.chapter.pageCount,
        initialPage: v.favorite.pageIndex,
      ),
    );
  }

  void _notify(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _savePageToGallery() async {
    final page = _views[_index].page;
    try {
      final local = page.localPath;
      final String path;
      if (local != null && local.isNotEmpty && File(local).existsSync()) {
        path = local;
      } else {
        final file = await DefaultCacheManager().getSingleFile(page.url);
        path = file.path;
      }
      if (!await Gal.hasAccess()) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          _notify('Gallery access denied');
          return;
        }
      }
      await Gal.putImage(path, album: 'Mango');
      _notify('Saved to gallery');
    } on GalException catch (e) {
      _notify('Could not save: ${e.type.message}');
    } catch (_) {
      _notify('Could not save page');
    }
  }

  void _downloadChapter() {
    final chapter = _views[_index].chapter;
    ref.read(downloadManagerProvider.notifier).enqueueChapter(chapter);
    _notify('Downloading ${chapterName(chapter)}');
  }

  Widget _buildMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) {
        switch (value) {
          case 'read':
            _openInChapter();
          case 'save':
            _savePageToGallery();
          case 'download':
            _downloadChapter();
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'read',
          child: Row(children: [
            Icon(Icons.menu_book_outlined),
            SizedBox(width: 12),
            Text('Read this chapter'),
          ]),
        ),
        PopupMenuItem(
          value: 'save',
          child: Row(children: [
            Icon(Icons.save_alt),
            SizedBox(width: 12),
            Text('Save page to gallery'),
          ]),
        ),
        PopupMenuItem(
          value: 'download',
          child: Row(children: [
            Icon(Icons.download_outlined),
            SizedBox(width: 12),
            Text('Download this chapter'),
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final lockPaging = _isZoomed || _pointerCount >= 2;
    final current = _views[_index];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Listener(
            onPointerDown: (_) => setState(() => _pointerCount++),
            onPointerUp: (_) =>
                setState(() => _pointerCount = (_pointerCount - 1).clamp(0, 10)),
            onPointerCancel: (_) =>
                setState(() => _pointerCount = (_pointerCount - 1).clamp(0, 10)),
            child: PageView.builder(
              controller: _controller,
              reverse: widget.args.reverse,
              physics: lockPaging
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: _views.length,
              itemBuilder: (context, i) {
                final v = _views[i];
                return ZoomablePage(
                  key: ValueKey('fav-${v.favorite.id}'),
                  provider: _providerFor(v),
                  onZoomChanged: (z) {
                    if (z != _isZoomed) setState(() => _isZoomed = z);
                  },
                  onTap: () => setState(() => _showOverlay = !_showOverlay),
                );
              },
            ),
          ),
          IgnorePointer(
            ignoring: !_showOverlay,
            child: AnimatedOpacity(
              opacity: _showOverlay ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  bottom: 4,
                ),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      Expanded(
                        child: Text(
                          '${chapterName(current.chapter)} · p.${current.favorite.pageIndex + 1}',
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${_index + 1} / ${_views.length}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      _buildMenu(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
