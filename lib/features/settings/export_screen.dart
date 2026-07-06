import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/providers.dart';

/// Exports the whole library as a reference-format JSON document, optionally
/// including each series' resume position. Copy it or share it as a file to
/// move your library to another device.
class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  bool _includeProgress = true;
  bool _includeFavoritePages = true;
  String? _json;
  int _localBooksSkipped = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _rebuild();
  }

  Future<void> _rebuild() async {
    setState(() => _loading = true);
    final result = await ref.read(mangaRepositoryProvider).exportLibraryJson(
          includeProgress: _includeProgress,
          includeFavoritePages: _includeFavoritePages,
        );
    if (mounted) {
      setState(() {
        _json = result.json;
        _localBooksSkipped = result.localBooksSkipped;
        _loading = false;
      });
    }
  }

  void _copy() {
    final json = _json;
    if (json == null) return;
    Clipboard.setData(ClipboardData(text: json));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Copied to clipboard')));
  }

  Future<void> _share() async {
    final json = _json;
    if (json == null) return;
    try {
      final dir = await getTemporaryDirectory();
      final file = File(p.join(dir.path, 'mango-library.json'));
      await file.writeAsString(json);
      await Share.shareXFiles([XFile(file.path)], subject: 'Mango library');
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Could not share file')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export library')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            title: const Text('Include reading progress'),
            subtitle: const Text('Resume position (chapter + page) per series'),
            value: _includeProgress,
            onChanged: (v) {
              setState(() => _includeProgress = v);
              _rebuild();
            },
          ),
          SwitchListTile(
            title: const Text('Include favorite pages'),
            subtitle: const Text('Your favorited pages per series'),
            value: _includeFavoritePages,
            onChanged: (v) {
              setState(() => _includeFavoritePages = v);
              _rebuild();
            },
          ),
          const Divider(height: 1),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${_json!.length} characters',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
            if (_localBooksSkipped > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: Text(
                  '$_localBooksSkipped locally-added '
                  '${_localBooksSkipped == 1 ? 'book' : 'books'} skipped '
                  "(no shared source — can't move devices).",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    _json!,
                    style: const TextStyle(
                        fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _copy,
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _share,
                      icon: const Icon(Icons.share),
                      label: const Text('Share file'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
