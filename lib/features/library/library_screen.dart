import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router.dart';
import '../../shared/providers.dart';
import 'library_card.dart';
import 'library_entry.dart';
import 'library_sort.dart';

/// The library home: imported manga and books as a unified cover grid, split
/// into a Favorites section and a Library section (started items to the top).
class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  static const _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 160,
    childAspectRatio: 0.62,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  );

  void _showAddMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.collections_bookmark_outlined),
              title: const Text('Import manga (JSON)'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                Navigator.of(context).pushNamed(Routes.import);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: const Text('Add book (PDF / EPUB)'),
              onTap: () {
                Navigator.of(sheetContext).pop();
                Navigator.of(context).pushNamed(Routes.addBook);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaAsync = ref.watch(mangaListProvider);
    final booksAsync = ref.watch(bookListProvider);

    final allEntries = <LibraryEntry>[
      ...?mangaAsync.value?.map(LibraryEntry.manga),
      ...?booksAsync.value?.map(LibraryEntry.book),
    ];
    final filter = ref.watch(libraryFilterProvider);
    final entries = allEntries.where((e) {
      switch (filter) {
        case LibraryFilter.all:
          return true;
        case LibraryFilter.manga:
          return e.kind == LibraryKind.manga;
        case LibraryFilter.books:
          return e.kind == LibraryKind.book;
      }
    }).toList();
    final hasFavorites = entries.any((e) => e.isFavorite);
    final loading = mangaAsync.isLoading || booksAsync.isLoading;

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
        onPressed: () => _showAddMenu(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          if (allEntries.isNotEmpty) _FilterBar(filter: filter),
          Expanded(child: _content(context, ref, entries, allEntries, loading)),
        ],
      ),
    );
  }

  Widget _content(
    BuildContext context,
    WidgetRef ref,
    List<LibraryEntry> entries,
    List<LibraryEntry> allEntries,
    bool loading,
  ) {
    if (allEntries.isEmpty) {
      return loading
          ? const Center(child: CircularProgressIndicator())
          : const _EmptyState();
    }
    if (entries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Nothing here for this filter.'),
        ),
      );
    }
    final groups = groupLibrary(entries);
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
  }

  SliverPadding _grid(
    BuildContext context,
    WidgetRef ref,
    List<LibraryEntry> items,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverGrid.builder(
        gridDelegate: _gridDelegate,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final entry = items[i];
          return LibraryCard(
            entry: entry,
            onTap: () => _open(context, entry),
            onToggleFavorite: () => _toggleFavorite(ref, entry),
          );
        },
      ),
    );
  }

  void _open(BuildContext context, LibraryEntry entry) {
    if (entry.kind == LibraryKind.manga) {
      Navigator.of(context).pushNamed(Routes.detail, arguments: entry.mangaId);
    } else {
      Navigator.of(context).pushNamed(Routes.bookDetail, arguments: entry.bookId);
    }
  }

  void _toggleFavorite(WidgetRef ref, LibraryEntry entry) {
    if (entry.kind == LibraryKind.manga) {
      ref.read(mangaRepositoryProvider).toggleFavoriteByIdentifier(entry.mangaId!);
    } else {
      ref.read(bookRepositoryProvider).toggleFavoriteById(entry.bookId!);
    }
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

class _FilterBar extends ConsumerWidget {
  const _FilterBar({required this.filter});
  final LibraryFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SegmentedButton<LibraryFilter>(
          segments: const [
            ButtonSegment(value: LibraryFilter.all, label: Text('All')),
            ButtonSegment(value: LibraryFilter.manga, label: Text('Manga')),
            ButtonSegment(value: LibraryFilter.books, label: Text('Books')),
          ],
          selected: {filter},
          showSelectedIcon: false,
          onSelectionChanged: (s) =>
              ref.read(libraryFilterProvider.notifier).set(s.first),
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
          'Nothing here yet.\nTap + to import manga or add a book.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
