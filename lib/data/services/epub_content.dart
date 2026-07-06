import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:epubx/epubx.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:path/path.dart' as p;

/// One small rendered unit (a paragraph/heading/image block). Keeping items
/// small makes scroll-position memory precise regardless of how the EPUB packs
/// its chapters.
class EpubBlock {
  EpubBlock({required this.html, required this.chapterIndex, required this.isChapterStart});
  final String html;
  final int chapterIndex;
  final bool isChapterStart;
}

/// A table-of-contents entry pointing at the block where a chapter begins.
class EpubChapterRef {
  EpubChapterRef({required this.title, required this.blockIndex});
  final String title;
  final int blockIndex;
}

class ParsedEpub {
  ParsedEpub({
    required this.blocks,
    required this.chapters,
    required this.images,
    required this.imageAspects,
  });

  final List<EpubBlock> blocks;
  final List<EpubChapterRef> chapters;
  final Map<String, Uint8List> images;

  /// width/height per image (by basename), so the reader can reserve space
  /// before the image decodes — keeping scroll position stable.
  final Map<String, double> imageAspects;

  String? _key(String? src) =>
      src == null ? null : p.basename(src).toLowerCase();

  Uint8List? imageFor(String? src) {
    final k = _key(src);
    return k == null ? null : images[k];
  }

  double? aspectFor(String? src) {
    final k = _key(src);
    return k == null ? null : imageAspects[k];
  }
}

const _containers = {'div', 'section', 'article', 'main', 'body'};

/// Descend through single-wrapper containers, then return the block-level
/// children to render as individual items.
List<dom.Element> _blockElements(dom.Element body) {
  var el = body;
  while (el.children.length == 1 && _containers.contains(el.children.first.localName)) {
    el = el.children.first;
  }
  return el.children.isEmpty ? [el] : el.children;
}

Future<ParsedEpub> parseEpub(String filePath) async {
  final bytes = await File(filePath).readAsBytes();
  final book = await EpubReader.readBook(bytes);

  final images = <String, Uint8List>{};
  book.Content?.Images?.forEach((key, file) {
    final content = file.Content;
    if (content != null) {
      images[p.basename(key).toLowerCase()] = Uint8List.fromList(content);
    }
  });

  // Measure images once so the reader can reserve their height.
  final imageAspects = <String, double>{};
  for (final entry in images.entries) {
    try {
      final codec = await ui.instantiateImageCodec(entry.value);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      if (image.height > 0) {
        imageAspects[entry.key] = image.width / image.height;
      }
      image.dispose();
    } catch (_) {
      // Skip unreadable images; they just won't have reserved space.
    }
  }

  final titleByHref = <String, String>{};
  void collect(List<EpubChapter>? chapters) {
    if (chapters == null) return;
    for (final c in chapters) {
      final file = c.ContentFileName;
      final title = c.Title;
      if (file != null && title != null && title.isNotEmpty) {
        titleByHref.putIfAbsent(file, () => title);
      }
      collect(c.SubChapters);
    }
  }

  collect(book.Chapters);

  // Ordered (href, html) list from the spine, with a TOC fallback.
  final spine = <MapEntry<String, String>>[];
  final package = book.Schema?.Package;
  final htmlFiles = book.Content?.Html;
  if (package?.Spine?.Items != null &&
      package?.Manifest?.Items != null &&
      htmlFiles != null) {
    final hrefById = <String, String>{};
    for (final item in package!.Manifest!.Items!) {
      final id = item.Id;
      final href = item.Href;
      if (id != null && href != null) hrefById[id] = href;
    }
    for (final ref in package.Spine!.Items!) {
      final href = hrefById[ref.IdRef];
      if (href == null) continue;
      final html = htmlFiles[href]?.Content;
      if (html != null) spine.add(MapEntry(href, html));
    }
  }
  if (spine.isEmpty && book.Chapters != null) {
    for (final c in book.Chapters!) {
      final html = c.HtmlContent;
      if (html != null) spine.add(MapEntry(c.ContentFileName ?? '', html));
    }
  }

  final blocks = <EpubBlock>[];
  final chapters = <EpubChapterRef>[];

  for (var ci = 0; ci < spine.length; ci++) {
    final href = spine[ci].key;
    final rawHtml = spine[ci].value;
    final startIndex = blocks.length;

    final title = titleByHref[href];
    if (title != null && title.isNotEmpty) {
      chapters.add(EpubChapterRef(title: title, blockIndex: startIndex));
    }

    List<dom.Element> elements;
    try {
      final body = html_parser.parse(rawHtml).body;
      elements = body == null ? const [] : _blockElements(body);
    } catch (_) {
      elements = const [];
    }

    if (elements.isEmpty) {
      blocks.add(EpubBlock(html: rawHtml, chapterIndex: ci, isChapterStart: true));
      continue;
    }

    var first = true;
    for (final el in elements) {
      final html = el.outerHtml;
      if (html.trim().isEmpty) continue;
      blocks.add(EpubBlock(
        html: html,
        chapterIndex: ci,
        isChapterStart: first,
      ));
      first = false;
    }
    if (first) {
      // Nothing added; keep a placeholder so the chapter isn't empty.
      blocks.add(EpubBlock(html: rawHtml, chapterIndex: ci, isChapterStart: true));
    }
  }

  return ParsedEpub(
    blocks: blocks,
    chapters: chapters,
    images: images,
    imageAspects: imageAspects,
  );
}
