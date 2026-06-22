import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'download_manager.dart' show kPaceDefaultMs;

/// Tiny persisted key/value settings store backed by a JSON file in app
/// storage. Avoids pulling in a separate preferences plugin for the handful of
/// values the app needs.
class SettingsService {
  SettingsService._(this._file, this._data);

  final File _file;
  Map<String, dynamic> _data;

  static Future<SettingsService> create() async {
    final docs = await getApplicationDocumentsDirectory();
    final file = File(p.join(docs.path, 'settings.json'));
    Map<String, dynamic> data = {};
    if (file.existsSync()) {
      try {
        data = (jsonDecode(file.readAsStringSync()) as Map).cast<String, dynamic>();
      } catch (_) {
        // Corrupt settings file: start fresh rather than crash.
      }
    }
    return SettingsService._(file, data);
  }

  int get paceMs => (_data['paceMs'] as int?) ?? kPaceDefaultMs;

  Future<void> setPaceMs(int ms) => _write('paceMs', ms);

  /// Global default reading direction ('ltr' or 'rtl'); RTL by default.
  String get readingDirection => (_data['readingDirection'] as String?) ?? 'rtl';

  Future<void> setReadingDirection(String dir) =>
      _write('readingDirection', dir);

  Future<void> _write(String key, Object value) async {
    _data = {..._data, key: value};
    try {
      await _file.writeAsString(jsonEncode(_data));
    } catch (_) {
      // Best-effort persistence; ignore write failures.
    }
  }
}
