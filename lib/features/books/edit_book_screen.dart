import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/providers.dart';

/// Edit a book's metadata (title, author, series, reading mode, cover).
class EditBookScreen extends ConsumerStatefulWidget {
  const EditBookScreen({super.key, required this.bookId});

  final int bookId;

  @override
  ConsumerState<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends ConsumerState<EditBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _seriesController = TextEditingController();
  String _readingMode = 'scroll';
  String _type = 'pdf';
  Uint8List? _coverOverride;
  bool _loaded = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final book = await ref.read(databaseProvider).bookDao.getById(widget.bookId);
    if (book != null && mounted) {
      setState(() {
        _titleController.text = book.title;
        _authorController.text = book.author ?? '';
        _seriesController.text = book.series ?? '';
        _readingMode = book.readingMode;
        _type = book.type;
        _loaded = true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _seriesController.dispose();
    super.dispose();
  }

  Future<void> _changeCover() async {
    final picked = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    final bytes = picked?.files.single.bytes;
    if (bytes != null) setState(() => _coverOverride = bytes);
  }

  Future<void> _save() async {
    if (_titleController.text.trim().isEmpty) return;
    setState(() => _busy = true);
    await ref.read(bookRepositoryProvider).updateMetadata(
          widget.bookId,
          title: _titleController.text.trim(),
          author: _authorController.text.trim().isEmpty
              ? null
              : _authorController.text.trim(),
          series: _seriesController.text.trim().isEmpty
              ? null
              : _seriesController.text.trim(),
          readingMode: _type == 'pdf' ? _readingMode : null,
          coverBytes: _coverOverride,
        );
    if (mounted) Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Edit book')),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
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
            if (_type == 'pdf') ...[
              const SizedBox(height: 16),
              Text('Reading mode',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'scroll', label: Text('Scroll')),
                  ButtonSegment(value: 'paged', label: Text('Paged')),
                ],
                selected: {_readingMode},
                onSelectionChanged: (s) =>
                    setState(() => _readingMode = s.first),
              ),
            ],
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _changeCover,
              icon: const Icon(Icons.image_outlined),
              label: Text(_coverOverride == null
                  ? 'Change cover'
                  : 'Cover selected'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _busy ? null : _save,
              icon: const Icon(Icons.check),
              label: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
