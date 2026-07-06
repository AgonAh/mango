import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers.dart';
import 'library_entry.dart';

/// Drag-to-reorder favorites across manga and books. The new order is written
/// to each item's own table on every move.
class ReorderFavoritesScreen extends ConsumerStatefulWidget {
  const ReorderFavoritesScreen({super.key});

  @override
  ConsumerState<ReorderFavoritesScreen> createState() =>
      _ReorderFavoritesScreenState();
}

class _ReorderFavoritesScreenState
    extends ConsumerState<ReorderFavoritesScreen> {
  List<LibraryEntry> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final manga = await ref.read(mangaRepositoryProvider).getLibrary();
    final books = await ref.read(bookRepositoryProvider).getBooks();
    final favorites = <LibraryEntry>[
      ...manga.where((m) => m.isFavorite).map(LibraryEntry.manga),
      ...books.where((b) => b.isFavorite).map(LibraryEntry.book),
    ]..sort((a, b) {
        final ao = a.favoriteOrder;
        final bo = b.favoriteOrder;
        if (ao != null && bo != null) return ao.compareTo(bo);
        if (ao != null) return -1;
        if (bo != null) return 1;
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      });
    if (mounted) {
      setState(() {
        _items = favorites;
        _loading = false;
      });
    }
  }

  Future<void> _persist() async {
    final db = ref.read(databaseProvider);
    for (var i = 0; i < _items.length; i++) {
      final entry = _items[i];
      if (entry.kind == LibraryKind.manga) {
        await db.mangaDao.setFavorite(entry.mangaId!, true, favoriteOrder: i);
      } else {
        await db.bookDao.setFavorite(entry.bookId!, true, favoriteOrder: i);
      }
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
    _persist();
  }

  Widget _leading(LibraryEntry e) {
    Widget child;
    if (e.coverPath != null && e.coverPath!.isNotEmpty) {
      child = Image.file(File(e.coverPath!), width: 36, height: 50, fit: BoxFit.cover);
    } else if (e.coverUrl != null && e.coverUrl!.isNotEmpty) {
      child = CachedNetworkImage(
        imageUrl: e.coverUrl!,
        width: 36,
        height: 50,
        fit: BoxFit.cover,
        placeholder: (_, __) => const ColoredBox(color: Colors.black26),
        errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
      );
    } else {
      child = const SizedBox(
        width: 36,
        height: 50,
        child: ColoredBox(color: Colors.black26),
      );
    }
    return ClipRRect(borderRadius: BorderRadius.circular(4), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reorder favorites')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(child: Text('No favorites yet.'))
              : ReorderableListView.builder(
                  itemCount: _items.length,
                  onReorder: _onReorder,
                  itemBuilder: (context, i) {
                    final e = _items[i];
                    return ListTile(
                      key: ValueKey('${e.kind}-${e.mangaId ?? e.bookId}'),
                      leading: _leading(e),
                      title: Text(e.title),
                      subtitle: e.badge != null ? Text(e.badge!) : null,
                      trailing: const Icon(Icons.drag_handle),
                    );
                  },
                ),
    );
  }
}
