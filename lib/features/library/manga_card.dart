import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/db/database.dart';

/// A single cover tile: thumbnail with the title overlaid, a favorite toggle,
/// and a small "reading" badge when the series has been started.
class MangaCard extends StatelessWidget {
  const MangaCard({
    super.key,
    required this.manga,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final MangaRow manga;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final started = manga.lastReadAt != null;

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: manga.thumbnail,
              fit: BoxFit.cover,
              placeholder: (_, __) => const ColoredBox(color: Colors.black26),
              errorWidget: (_, __, ___) => const ColoredBox(
                color: Colors.black26,
                child: Icon(Icons.broken_image, color: Colors.white24),
              ),
            ),
            // Bottom gradient for title legibility.
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
                  manga.title,
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
            if (started)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Reading',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  manga.isFavorite ? Icons.star : Icons.star_border,
                  color: manga.isFavorite
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white70,
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
