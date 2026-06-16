import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/reference.dart';
import '../../shared/providers.dart';

/// Add or update manga by pasting JSON or providing a URL to a reference file.
class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  final _urlController = TextEditingController();
  final _rawController = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _urlController.dispose();
    _rawController.dispose();
    super.dispose();
  }

  Future<void> _run(Future<List<ReferenceManga>> Function() load) async {
    setState(() => _busy = true);
    try {
      final refs = await load();
      final result = await ref.read(mangaRepositoryProvider).import(refs);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Imported ${result.total} — '
            '${result.added} new, ${result.updated} updated',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Import failed: $e')));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.read(jsonImportServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add / update manga')),
      body: AbsorbPointer(
        absorbing: _busy,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('From a URL', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                hintText: 'https://example.com/reference.json',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _busy
                  ? null
                  : () => _run(() => service.fromUrl(_urlController.text)),
              icon: const Icon(Icons.cloud_download_outlined),
              label: const Text('Import from URL'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            Text('Paste JSON', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _rawController,
              maxLines: 10,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              decoration: const InputDecoration(
                hintText: '[ { "title": ..., "identifier": ..., ... } ]',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _busy
                  ? null
                  : () => _run(() async => service.fromRaw(_rawController.text)),
              icon: const Icon(Icons.save_outlined),
              label: const Text('Import JSON'),
            ),
            if (_busy)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
