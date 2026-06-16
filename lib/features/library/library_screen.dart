import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router.dart';
import '../../data/db/database.dart';
import '../../shared/providers.dart';
import 'library_sort.dart';
import 'manga_card.dart';

/// The library home: imported manga as a cover grid, split into a Favorites
/// section and a Library section (started series sorted to the top).
class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  static const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 160,
    childAspectRatio: 0.62,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final library = ref.watch(mangaListProvider);
    final hasFavorites =
        (library.value ?? const []).any((m) => m.isFavorite);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mango'),
        actions: [
          if (hasFavorites)
            IconButton(
              icon: const Icon(Icons.swap_vert),
              tooltip: 'Reorder favorites',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.reorderFavorites),
            ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
            onPressed: () => Navigator.of(context).pushNamed(Routes.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.import),
        child: const Icon(Icons.add),
      ),
      body: library.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (all) {
          if (all.isEmpty) return const _EmptyState();
          final groups = groupLibrary(all);
          return CustomScrollView(
            slivers: [
              if (groups.favorites.isNotEmpty) ...[
                const _SectionHeader('Favorites'),
                _grid(context, ref, groups.favorites),
              ],
              if (groups.others.isNotEmpty) ...[
                const _SectionHeader('Library'),
                _grid(context, ref, groups.others),
              ],
              const SliverToBoxAdapter(child: SizedBox(height: 88)),
            ],
          );
        },
      ),
    );
  }

  SliverPadding _grid(
    BuildContext context,
    WidgetRef ref,
    List<MangaRow> items,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverGrid.builder(
        gridDelegate: _gridDelegate,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final manga = items[i];
          return MangaCard(
            manga: manga,
            onTap: () => Navigator.of(context).pushNamed(
              Routes.detail,
              arguments: manga.identifier,
            ),
            onToggleFavorite: () =>
                ref.read(mangaRepositoryProvider).toggleFavorite(manga),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No manga yet.\nTap + to import a reference.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
