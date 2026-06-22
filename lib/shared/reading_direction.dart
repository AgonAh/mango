import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

const String kDirLtr = 'ltr';
const String kDirRtl = 'rtl';

/// Resolves the effective direction: a per-manga override wins, otherwise the
/// global default. Returns true when right-to-left.
bool directionIsRtl(String? mangaOverride, String globalDefault) =>
    (mangaOverride ?? globalDefault) == kDirRtl;

/// Reactive global reading-direction default, persisted via [SettingsService].
class GlobalReadingDirection extends Notifier<String> {
  @override
  String build() => ref.read(settingsServiceProvider).readingDirection;

  void set(String dir) {
    state = dir;
    ref.read(settingsServiceProvider).setReadingDirection(dir);
  }
}

final globalReadingDirectionProvider =
    NotifierProvider<GlobalReadingDirection, String>(
  GlobalReadingDirection.new,
);
