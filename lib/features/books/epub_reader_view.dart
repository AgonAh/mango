import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../data/db/database.dart';
import '../../data/services/epub_content.dart';
import '../../shared/providers.dart';

/// Native EPUB reader: parses the book with epubx and lays chapters out as a
/// continuous, free-scrolling list of HTML widgets (no webview). Remembers the
/// position by chapter index + within-chapter offset.
class EpubReaderView extends ConsumerStatefulWidget {
  const EpubReaderView({super.key, required this.book});

  final BookRow book;

  @override
  ConsumerState<EpubReaderView> createState() => _EpubReaderViewState();
}

class _EpubReaderViewState extends ConsumerState<EpubReaderView> {
  final _itemScrollController = ItemScrollController();
  final _positionsListener = ItemPositionsListener.create();

  ParsedEpub? _epub;
  bool _loading = true;
  double _fontSize = 18;

  int _savedIndex = 0;
  double _savedOffset = 0;
  bool _restored = false;
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    final parts = widget.book.lastLocation?.split('|');
    if (parts != null && parts.length == 2) {
      _savedIndex = int.tryParse(parts[0]) ?? 0;
      _savedOffset = double.tryParse(parts[1]) ?? 0;
    }
    _positionsListener.itemPositions.addListener(_onScroll);
    _load();
  }

  Future<void> _load() async {
    final parsed = await parseEpub(widget.book.filePath);
    if (!mounted) return;
    setState(() {
      _epub = parsed;
      _loading = false;
      if (_savedIndex >= parsed.blocks.length) _savedIndex = 0;
    });
    // Restore the exact position once the list has laid out.
    SchedulerBinding.instance.addPostFrameCallback((_) => _restore());
  }

  void _restore() {
    if (_restored) return;
    if (!_itemScrollController.isAttached) return;
    _restored = true;
    if (_savedIndex > 0 || _savedOffset != 0) {
      _itemScrollController.jumpTo(index: _savedIndex, alignment: _savedOffset);
    }
  }

  void _onScroll() {
    if (!_restored) return; // don't overwrite the saved spot before restoring
    final positions = _positionsListener.itemPositions.value;
    final visible = positions.where((p) => p.itemTrailingEdge > 0);
    if (visible.isEmpty) return;
    final top = visible.reduce((a, b) => a.index < b.index ? a : b);
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(databaseProvider).bookDao.saveEpubLocation(
            widget.book.id,
            '${top.index}|${top.itemLeadingEdge}',
          );
    });
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    _positionsListener.itemPositions.removeListener(_onScroll);
    super.dispose();
  }

  void _openChapters() {
    final epub = _epub;
    if (epub == null) return;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => epub.chapters.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No chapter list in this book'),
            )
          : ListView(
              children: [
                for (final chapter in epub.chapters)
                  ListTile(
                    title: Text(chapter.title),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      if (_itemScrollController.isAttached) {
                        _itemScrollController.scrollTo(
                          index: chapter.blockIndex,
                          alignment: 0,
                          duration: const Duration(milliseconds: 300),
                        );
                      }
                    },
                  ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final epub = _epub;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_decrease),
            tooltip: 'Smaller text',
            onPressed: () => setState(
                () => _fontSize = (_fontSize - 2).clamp(12, 32).toDouble()),
          ),
          IconButton(
            icon: const Icon(Icons.text_increase),
            tooltip: 'Larger text',
            onPressed: () => setState(
                () => _fontSize = (_fontSize + 2).clamp(12, 32).toDouble()),
          ),
          IconButton(
            icon: const Icon(Icons.menu_book_outlined),
            tooltip: 'Chapters',
            onPressed: _openChapters,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : (epub == null || epub.blocks.isEmpty)
              ? const Center(child: Text('Could not read this EPUB'))
              : ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: _positionsListener,
                  itemCount: epub.blocks.length,
                  itemBuilder: (context, i) => _block(epub, epub.blocks[i]),
                ),
    );
  }

  Widget _block(ParsedEpub epub, EpubBlock block) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, block.isChapterStart ? 28 : 4, 20, 4),
      child: HtmlWidget(
        block.html,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: _fontSize,
          height: 1.5,
        ),
        customWidgetBuilder: (element) {
          if (element.localName == 'img') {
            final src = element.attributes['src'];
            final bytes = epub.imageFor(src);
            if (bytes == null) return const SizedBox.shrink();
            final image = Image.memory(bytes, fit: BoxFit.contain);
            final aspect = epub.aspectFor(src);
            // Reserve the image's height up front so layout (and the saved
            // scroll position) doesn't shift when it finishes decoding.
            return aspect != null && aspect > 0
                ? AspectRatio(aspectRatio: aspect, child: image)
                : image;
          }
          return null;
        },
      ),
    );
  }
}
