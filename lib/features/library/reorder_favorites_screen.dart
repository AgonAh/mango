import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/database.dart';
import '../../shared/providers.dart';

/// Drag-to-reorder the favorites. The new order is persisted to
/// [MangaRepository.reorderFavorites] on every move.
class ReorderFavoritesScreen extends ConsumerStatefulWidget {
  const ReorderFavoritesScreen({super.key});

  @override
  ConsumerState<ReorderFavoritesScreen> createState() =>
      _ReorderFavoritesScreenState();
}

class _ReorderFavoritesScreenState
    extends ConsumerState<ReorderFavoritesScreen> {
  List<MangaRow> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await ref.read(mangaRepositoryProvider).getLibrary();
    final favorites = all.where((m) => m.isFavorite).toList()
      ..sort((a, b) {
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

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
    ref
        .read(mangaRepositoryProvider)
        .reorderFavorites(_items.map((m) => m.identifier).toList());
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
                    final m = _items[i];
                    return ListTile(
                      key: ValueKey(m.identifier),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: m.thumbnail,
                          width: 36,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              const ColoredBox(color: Colors.black26),
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(m.title),
                      trailing: const Icon(Icons.drag_handle),
                    );
                  },
                ),
    );
  }
}
