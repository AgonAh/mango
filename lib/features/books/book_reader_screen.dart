import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

import '../../data/db/database.dart';
import '../../shared/providers.dart';
import 'epub_reader_view.dart';

/// Reader for imported books. PDFs render via pdfx (scroll = pinch-zoom,
/// paged = swipe). EPUBs get a placeholder until Phase 4.
class BookReaderScreen extends ConsumerStatefulWidget {
  const BookReaderScreen({super.key, required this.bookId});

  final int bookId;

  @override
  ConsumerState<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends ConsumerState<BookReaderScreen> {
  BookRow? _book;
  bool _loaded = false;
  bool _downloading = false;
  bool _error = false;

  PdfController? _paged;
  PdfControllerPinch? _pinch;
  int _page = 1;
  int _count = 0;
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(databaseProvider);
    var book = await db.bookDao.getById(widget.bookId);
    if (book != null) {
      db.bookDao.touchLastRead(book.id);

      // JSON-imported books download their file on first read.
      if (book.filePath.isEmpty && (book.sourceUrl?.isNotEmpty ?? false)) {
        if (mounted) setState(() => _downloading = true);
        try {
          book = await ref.read(bookRepositoryProvider).ensureLocalFile(book);
        } catch (_) {
          if (mounted) {
            setState(() {
              _book = book;
              _loaded = true;
              _downloading = false;
              _error = true;
            });
          }
          return;
        }
      }

      if (book.type == 'pdf' && book.filePath.isNotEmpty) {
        final initial = book.lastPage + 1;
        final document = PdfDocument.openFile(book.filePath);
        if (book.readingMode == 'paged') {
          _paged = PdfController(document: document, initialPage: initial);
        } else {
          _pinch = PdfControllerPinch(document: document, initialPage: initial);
        }
      }
    }
    if (mounted) {
      setState(() {
        _book = book;
        _page = (book?.lastPage ?? 0) + 1;
        _loaded = true;
        _downloading = false;
      });
    }
  }

  void _onPageChanged(int page) {
    _count = _paged?.pagesCount ?? _pinch?.pagesCount ?? _count;
    setState(() => _page = page);
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 300), () {
      final db = ref.read(databaseProvider);
      db.bookDao.savePdfPage(widget.bookId, page - 1);
      if (_count > 0) db.bookDao.savePageCount(widget.bookId, _count);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _saveTimer?.cancel();
    // Flush the latest page so resume is exact.
    ref.read(databaseProvider).bookDao.savePdfPage(widget.bookId, _page - 1);
    _paged?.dispose();
    _pinch?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_downloading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Downloading book…',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }
    if (!_loaded) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final book = _book;
    if (book == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Book not found')),
      );
    }
    if (_error || book.filePath.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(book.title)),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "Couldn't download this book. Check your connection and try again.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    if (book.type == 'epub') {
      return EpubReaderView(book: book);
    }

    // pdfx renders correctly only with clean, bounded constraints, so the
    // viewer is the Scaffold body (not a Stack overlay).
    final viewer = _paged != null
        ? PdfView(
            controller: _paged!,
            onPageChanged: _onPageChanged,
            onDocumentLoaded: (doc) => setState(() => _count = doc.pagesCount),
          )
        : PdfViewPinch(
            controller: _pinch!,
            onPageChanged: _onPageChanged,
            onDocumentLoaded: (doc) => setState(() => _count = doc.pagesCount),
          );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(book.title,
            style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                _count > 0 ? '$_page / $_count' : '$_page',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: viewer,
    );
  }
}
