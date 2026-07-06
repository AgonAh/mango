import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'library_entry.dart';

/// A single cover tile for either a manga or a book: cover with the title
/// overlaid, a favorite toggle, a type badge (PDF/EPUB) for books, and a
/// "reading" badge for started items.
class LibraryCard extends StatelessWidget {
  const LibraryCard({
    super.key,
    required this.entry,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final LibraryEntry entry;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  Widget _cover() {
    final path = entry.coverPath;
    if (path != null && path.isNotEmpty) {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black26),
      );
    }
    final url = entry.coverUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, __) => const ColoredBox(color: Colors.black26),
        errorWidget: (_, __, ___) => const ColoredBox(
          color: Colors.black26,
          child: Icon(Icons.broken_image, color: Colors.white24),
        ),
      );
    }
    return const ColoredBox(
      color: Colors.black26,
      child: Icon(Icons.menu_book, color: Colors.white24),
    );
  }

  @override
  Widget build(BuildContext context) {
    final started = entry.lastReadAt != null;
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _cover(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
                child: Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: _Badge(
                text: entry.badge ?? (started ? 'Reading' : null),
                color: entry.badge != null ? Colors.black87 : primary,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  entry.isFavorite ? Icons.star : Icons.star_border,
                  color: entry.isFavorite ? primary : Colors.white70,
                ),
                onPressed: onToggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});
  final String? text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (text == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text!,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
