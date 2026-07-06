import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart'
    hide DownloadProgress;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router.dart';
import '../../data/db/database.dart';
import '../../shared/providers.dart';
import 'edit_book_screen.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({super.key, required this.bookId});

  final int bookId;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    BookRow book,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete book?'),
        content: Text('Remove "${book.title}" and its file from the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(bookRepositoryProvider).deleteBook(book.id);
      if (context.mounted) Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailProvider(bookId));
    final book = bookAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? 'Book'),
        actions: [
          if (book != null) ...[
            IconButton(
              icon: Icon(book.isFavorite ? Icons.star : Icons.star_border),
              color: book.isFavorite
                  ? Theme.of(context).colorScheme.primary
                  : null,
              onPressed: () =>
                  ref.read(bookRepositoryProvider).toggleFavorite(book),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditBookScreen(bookId: book.id),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, ref, book),
            ),
          ],
        ],
      ),
      body: book == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 110,
                        height: 154,
                        child: _cover(book),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.title,
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 6),
                          if (book.author != null)
                            Text(book.author!,
                                style: Theme.of(context).textTheme.bodyMedium),
                          if (book.series != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(book.series!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      )),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            '${book.type.toUpperCase()} · ${_positionLabel(book)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  icon: Icon(_hasProgress(book)
                      ? Icons.play_arrow
                      : Icons.menu_book),
                  label: Text(_hasProgress(book) ? 'Continue' : 'Read'),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(Routes.bookReader, arguments: book.id),
                ),
              ],
            ),
    );
  }

  bool _hasProgress(BookRow book) =>
      book.lastPage > 0 || (book.lastLocation?.isNotEmpty ?? false);

  String _positionLabel(BookRow book) {
    if (!_hasProgress(book)) return 'not started';
    if (book.type == 'pdf') return 'on page ${book.lastPage + 1}';
    return 'in progress';
  }

  Widget _cover(BookRow book) {
    final path = book.coverPath;
    if (path != null && File(path).existsSync()) {
      return Image.file(File(path), fit: BoxFit.cover);
    }
    final url = book.coverUrl;
    if (url != null && url.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, __) => const ColoredBox(color: Colors.black26),
        errorWidget: (_, __, ___) => const ColoredBox(
          color: Colors.black26,
          child: Icon(Icons.menu_book, color: Colors.white24),
        ),
      );
    }
    return const ColoredBox(
      color: Colors.black26,
      child: Icon(Icons.menu_book, color: Colors.white24),
    );
  }
}
