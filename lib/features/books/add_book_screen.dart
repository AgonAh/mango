import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_repository.dart';
import '../../shared/providers.dart';

/// Pick a PDF/EPUB, review auto-extracted metadata, then save it to the
/// library.
class AddBookScreen extends ConsumerStatefulWidget {
  const AddBookScreen({super.key});

  @override
  ConsumerState<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _seriesController = TextEditingController();

  BookDraft? _draft;
  Uint8List? _coverOverride;
  String _readingMode = 'scroll';
  bool _busy = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _seriesController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub'],
    );
    final path = picked?.files.single.path;
    if (path == null) return;
    setState(() => _busy = true);
    try {
      final draft = await ref.read(bookRepositoryProvider).analyze(path);
      setState(() {
        _draft = draft;
        _titleController.text = draft.suggestedTitle;
        _authorController.text = draft.suggestedAuthor ?? '';
        _readingMode = 'scroll';
        _coverOverride = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _changeCover() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    final bytes = picked?.files.single.bytes;
    if (bytes != null) setState(() => _coverOverride = bytes);
  }

  Future<void> _save() async {
    final draft = _draft;
    if (draft == null) return;
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please enter a title')));
      return;
    }
    setState(() => _busy = true);
    try {
      await ref.read(bookRepositoryProvider).createBook(
            draft: draft,
            title: _titleController.text.trim(),
            author: _authorController.text.trim().isEmpty
                ? null
                : _authorController.text.trim(),
            series: _seriesController.text.trim().isEmpty
                ? null
                : _seriesController.text.trim(),
            readingMode: draft.type == BookType.epub ? 'scroll' : _readingMode,
            coverOverride: _coverOverride,
          );
      if (mounted) Navigator.of(context).maybePop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Could not add book: $e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    return Scaffold(
      appBar: AppBar(title: const Text('Add book')),
      body: AbsorbPointer(
        absorbing: _busy,
        child: draft == null ? _picker() : _form(draft),
      ),
    );
  }

  Widget _picker() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_busy) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Reading file…'),
          ] else
            FilledButton.icon(
              onPressed: _pickFile,
              icon: const Icon(Icons.upload_file_outlined),
              label: const Text('Choose a PDF or EPUB'),
            ),
        ],
      ),
    );
  }

  Widget _form(BookDraft draft) {
    final coverBytes = _coverOverride ?? draft.coverBytes;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 96,
                height: 134,
                child: coverBytes != null
                    ? Image.memory(coverBytes, fit: BoxFit.cover)
                    : const ColoredBox(
                        color: Colors.black26,
                        child: Icon(Icons.menu_book, color: Colors.white24),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(draft.type.name.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _changeCover,
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Change cover'),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
              labelText: 'Title', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _authorController,
          decoration: const InputDecoration(
              labelText: 'Author (optional)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _seriesController,
          decoration: const InputDecoration(
              labelText: 'Series / tags (optional)',
              border: OutlineInputBorder()),
        ),
        if (draft.type == BookType.pdf) ...[
          const SizedBox(height: 16),
          Text('Reading mode', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'scroll', label: Text('Scroll')),
              ButtonSegment(value: 'paged', label: Text('Paged')),
            ],
            selected: {_readingMode},
            onSelectionChanged: (s) => setState(() => _readingMode = s.first),
          ),
        ],
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _busy ? null : _save,
          icon: const Icon(Icons.check),
          label: const Text('Add to library'),
        ),
      ],
    );
  }
}
