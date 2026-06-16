import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/download_manager.dart';
import '../../shared/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static String paceLabel(int ms) {
    if (ms <= 1000) {
      final perSec = 1000 / ms;
      final text =
          perSec % 1 == 0 ? perSec.toStringAsFixed(0) : perSec.toStringAsFixed(1);
      return '$text files / sec';
    }
    final secs = ms / 1000;
    final text = secs % 1 == 0 ? secs.toStringAsFixed(0) : secs.toStringAsFixed(1);
    return '1 file / ${text}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pace = ref.watch(downloadManagerProvider).paceMs;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SectionHeader('Downloads'),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Download speed',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  '${paceLabel(pace)} · slower is gentler on the source server',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                Slider(
                  value: pace.toDouble(),
                  min: kPaceMinMs.toDouble(),
                  max: kPaceMaxMs.toDouble(),
                  divisions: (kPaceMaxMs - kPaceMinMs) ~/ 500,
                  label: paceLabel(pace),
                  onChanged: (v) => ref
                      .read(downloadManagerProvider.notifier)
                      .setPace(v.round()),
                ),
              ],
            ),
          ),
          const Divider(),
          const _SectionHeader('Storage'),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Clear image cache'),
            subtitle: const Text(
              'Frees cached online images. Downloaded chapters are kept.',
            ),
            onTap: () async {
              await DefaultCacheManager().emptyCache();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image cache cleared')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
