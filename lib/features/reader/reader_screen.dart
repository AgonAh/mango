import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    hide DownloadProgress;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';

import '../../data/db/database.dart';
import '../../shared/chapter_format.dart';
import '../../shared/providers.dart';
import '../../shared/reading_direction.dart';
import 'zoomable_page.dart';

/// Arguments for opening the reader at a specific chapter and page.
class ReaderArgs {
  const ReaderArgs({
    required this.mangaId,
    required this.chapterId,
    required this.chapterLabel,
    required this.pageCount,
    this.initialPage = 0,
  });

  final String mangaId;
  final int chapterId;
  final String chapterLabel;
  final int pageCount;
  final int initialPage;
}

/// Horizontal paged reader with pinch/double-tap zoom, zoom-gated swiping,
/// swipe-to-adjacent-chapter at the page boundaries, 3-page prefetch, and
/// debounced progress writes.
///
/// Each chapter's PageView carries two sentinel slots — one before the first
/// page and one after the last. Because paging is disabled while a page is
/// zoomed in, the user can only reach a sentinel (and thus change chapters)
/// when fully zoomed out, which satisfies the swipe-to-next-chapter rule.
class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, required this.args});

  final ReaderArgs args;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  late PageController _controller;
  List<ChapterRow> _chapters = const [];
  List<PageRow> _pages = const [];
  int _chapterIndex = 0;
  int _currentPage = 0;
  bool _ready = false;
  bool _reverse = false; // true = right-to-left paging
  bool _isZoomed = false;
  bool _showOverlay = false;
  bool _transitioning = false;
  int _pointerCount = 0;
  int _pageViewIndex = 0;
  int _dragStartIndex = 0;
  double _overscroll = 0;
  Timer? _saveTimer;

  // A deliberate swipe past an interstitial must exceed this to change chapters.
  static const double _chapterSwipeThreshold = 80;

  bool get _hasPrev => _chapterIndex > 0;
  bool get _hasNext => _chapterIndex < _chapters.length - 1;
  ChapterRow get _chapter => _chapters[_chapterIndex];

  @override
  void initState() {
    super.initState();
    // Full-screen immersive reading; restored in dispose.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // keepPage: false so each chapter's initialPage is always honored rather
    // than the PageView restoring a stale page index from a previous chapter.
    _controller = PageController(keepPage: false);
    _init();
  }

  Future<void> _init() async {
    final db = ref.read(databaseProvider);
    final manga = await db.mangaDao.getByIdentifier(widget.args.mangaId);
    final globalDir = ref.read(globalReadingDirectionProvider);
    _reverse = directionIsRtl(manga?.readingDirection, globalDir);
    _chapters = await db.chapterDao.getChaptersForManga(widget.args.mangaId);
    var index = _chapters.indexWhere((c) => c.id == widget.args.chapterId);
    if (index < 0) index = 0;
    await _loadChapter(index, landing: widget.args.initialPage);
    if (mounted) setState(() => _ready = true);
  }

  /// Loads [index]'s pages and rebuilds the pager. [landing] is the real page
  /// to show (-1 means "last page", used when arriving from the next chapter).
  Future<void> _loadChapter(int index, {int landing = 0}) async {
    final db = ref.read(databaseProvider);
    final chapter = _chapters[index];
    final pages = await db.pageDao.getPagesForChapter(chapter.id);
    if (!mounted) return;

    final realLanding = landing == -1
        ? (pages.isEmpty ? 0 : pages.length - 1)
        : landing.clamp(0, pages.isEmpty ? 0 : pages.length - 1);

    final old = _controller;
    final fresh = PageController(initialPage: realLanding + 1, keepPage: false);
    setState(() {
      _chapterIndex = index;
      _pages = pages;
      _currentPage = realLanding;
      _pageViewIndex = realLanding + 1;
      _isZoomed = false;
      _overscroll = 0;
      _controller = fresh;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());

    ref
        .read(progressRepositoryProvider)
        .openChapter(widget.args.mangaId, chapter.id);
    _saveProgress(realLanding);
    WidgetsBinding.instance.addPostFrameCallback((_) => _prefetch(realLanding));
  }

  ImageProvider _providerFor(PageRow page) {
    final local = page.localPath;
    if (local != null && local.isNotEmpty) return FileImage(File(local));
    return CachedNetworkImageProvider(page.url);
  }

  void _prefetch(int fromReal) {
    for (var i = fromReal + 1; i <= fromReal + 3 && i < _pages.length; i++) {
      precacheImage(_providerFor(_pages[i]), context);
    }
  }

  void _saveProgress(int realIndex) {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 250), () {
      ref.read(progressRepositoryProvider).updatePage(
            _chapter.id,
            realIndex,
            pageCount: _pages.length,
          );
    });
  }

  Future<void> _transition(Future<void> Function() body) async {
    if (_transitioning) return;
    _transitioning = true;
    await body();
    _transitioning = false;
  }

  void _onPageChanged(int index) {
    _pageViewIndex = index;
    // Landing on an interstitial (sentinel) is a resting state: it must not
    // change chapters or touch any progress. Transitions only happen on a
    // deliberate further swipe (see _onScroll).
    if (index == 0 || index == _pages.length + 1) return;

    final real = index - 1;
    setState(() => _currentPage = real);
    _saveProgress(real);
    _prefetch(real);
  }

  /// Watches the pager's scroll so that a deliberate swipe *starting from* an
  /// interstitial advances to the adjacent chapter. Capturing the page index at
  /// drag start means the same swipe that brought you to the interstitial can't
  /// carry through into the next chapter.
  bool _onScroll(ScrollNotification n) {
    if (n is ScrollStartNotification) {
      _overscroll = 0;
      _dragStartIndex = _pageViewIndex;
    } else if (n is OverscrollNotification) {
      _overscroll += n.overscroll;
      _maybeChangeChapter();
    } else if (n is ScrollEndNotification) {
      _overscroll = 0;
    }
    return false;
  }

  void _maybeChangeChapter() {
    if (_transitioning || _overscroll.abs() < _chapterSwipeThreshold) return;
    final atTrailing = _dragStartIndex == _pages.length + 1;
    final atLeading = _dragStartIndex == 0;

    if (atTrailing && _hasNext) {
      _overscroll = 0;
      _transition(() => _loadChapter(_chapterIndex + 1, landing: 0));
    } else if (atLeading && _hasPrev) {
      _overscroll = 0;
      _transition(() => _loadChapter(_chapterIndex - 1, landing: -1));
    }
  }

  /// Steps one page within the current chapter ([delta] is -1 or +1). The
  /// PageView index is the real page index + 1 (slot 0 is the leading sentinel).
  void _goToPage(int delta) {
    final target = (_currentPage + delta).clamp(0, _pages.length - 1);
    _controller.animateToPage(
      target + 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _saveTimer?.cancel();
    // Flush the latest position so resume is exact even on abrupt exit.
    if (_ready && _pages.isNotEmpty) {
      ref.read(progressRepositoryProvider).updatePage(
            _chapter.id,
            _currentPage,
            pageCount: _pages.length,
          );
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavoritePage = _ready
        ? (ref
                .watch(isFavoritePageProvider(
                    (chapterId: _chapter.id, pageIndex: _currentPage)))
                .value ??
            false)
        : false;
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_ready
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                _buildPager(),
                _buildOverlay(isFavoritePage),
              ],
            ),
    );
  }

  Widget _buildPager() {
    // Disable paging while zoomed in or while a second finger is down, so a
    // pinch gesture reliably wins over the horizontal page-drag.
    final lockPaging = _isZoomed || _pointerCount >= 2;
    return Listener(
      onPointerDown: (_) => setState(() => _pointerCount++),
      onPointerUp: (_) =>
          setState(() => _pointerCount = (_pointerCount - 1).clamp(0, 10)),
      onPointerCancel: (_) =>
          setState(() => _pointerCount = (_pointerCount - 1).clamp(0, 10)),
      child: NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: PageView.builder(
        key: ValueKey('reader-chapter-${_chapter.id}'),
        controller: _controller,
        reverse: _reverse,
        physics: lockPaging
            ? const NeverScrollableScrollPhysics()
            : const PageScrollPhysics(),
        onPageChanged: _onPageChanged,
        itemCount: _pages.length + 2,
        itemBuilder: (context, index) {
        if (index == 0) {
          return _Interstitial(
            title: _hasPrev ? 'Previous chapter' : 'Start of manga',
            subtitle: _hasPrev
                ? '${chapterName(_chapters[_chapterIndex - 1])}\nSwipe again to go back'
                : null,
            icon: _hasPrev ? Icons.arrow_back : Icons.first_page,
            onTap: _toggleOverlay,
          );
        }
        if (index == _pages.length + 1) {
          return _Interstitial(
            title: _hasNext ? 'Next chapter' : 'Last chapter',
            subtitle: _hasNext
                ? '${chapterName(_chapters[_chapterIndex + 1])}\nSwipe again to continue'
                : null,
            icon: _hasNext ? Icons.arrow_forward : Icons.done_all,
            onTap: _toggleOverlay,
          );
        }
        final page = _pages[index - 1];
        return ZoomablePage(
          key: ValueKey('${_chapter.id}:${page.pageIndex}'),
          provider: _providerFor(page),
          onZoomChanged: (z) {
            if (z != _isZoomed) setState(() => _isZoomed = z);
          },
          onTap: _toggleOverlay,
        );
        },
        ),
      ),
    );
  }

  void _toggleOverlay() => setState(() => _showOverlay = !_showOverlay);

  Widget _buildReaderMenu(bool isFavoritePage) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) {
        switch (value) {
          case 'fav':
            ref.read(databaseProvider).favoritePageDao.toggle(
                  widget.args.mangaId,
                  _chapter.id,
                  _currentPage,
                );
          case 'save':
            _savePageToGallery();
          case 'download':
            ref.read(downloadManagerProvider.notifier).enqueueChapter(_chapter);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Downloading ${chapterName(_chapter)}')),
            );
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'fav',
          child: Row(
            children: [
              Icon(isFavoritePage ? Icons.bookmark : Icons.bookmark_border),
              const SizedBox(width: 12),
              Text(isFavoritePage ? 'Unfavorite page' : 'Favorite page'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'save',
          child: Row(
            children: [
              Icon(Icons.save_alt),
              SizedBox(width: 12),
              Text('Save page to gallery'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'download',
          child: Row(
            children: [
              Icon(Icons.download_outlined),
              SizedBox(width: 12),
              Text('Download this chapter'),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _savePageToGallery() async {
    if (_currentPage < 0 || _currentPage >= _pages.length) return;
    final page = _pages[_currentPage];
    void notify(String msg) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
      }
    }

    try {
      // Use the downloaded file if present, otherwise the cached image
      // (the page is on-screen, so it's already in the cache).
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
          notify('Gallery access denied');
          return;
        }
      }
      await Gal.putImage(path, album: 'Mango');
      notify('Saved to gallery');
    } on GalException catch (e) {
      notify('Could not save: ${e.type.message}');
    } catch (_) {
      notify('Could not save page');
    }
  }

  Widget _buildOverlay(bool isFavoritePage) {
    return IgnorePointer(
      ignoring: !_showOverlay,
      child: AnimatedOpacity(
        opacity: _showOverlay ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: Column(
          children: [
            _bar(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  Expanded(
                    child: Text(
                      chapterName(_chapter),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    '${_currentPage + 1} / ${_pages.length}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  _buildReaderMenu(isFavoritePage),
                ],
              ),
            ),
            const Spacer(),
            _bar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _currentPage > 0 ? () => _goToPage(-1) : null,
                    icon: const Icon(Icons.navigate_before),
                    label: const Text('Prev page'),
                  ),
                  TextButton.icon(
                    onPressed: _currentPage < _pages.length - 1
                        ? () => _goToPage(1)
                        : null,
                    icon: const Icon(Icons.navigate_next),
                    label: const Text('Next page'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar({required Widget child}) {
    return Container(
      color: Colors.black54,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 4,
      ),
      child: SafeArea(top: false, bottom: false, child: child),
    );
  }
}

/// Interstitial page shown before the first / after the last page of a
/// chapter. Resting here never changes chapters; only a deliberate further
/// swipe does (handled by the reader's scroll listener).
class _Interstitial extends StatelessWidget {
  const _Interstitial({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white54, size: 40),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
