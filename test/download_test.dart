import 'package:flutter_test/flutter_test.dart';
import 'package:mango/data/services/download_manager.dart';

void main() {
  group('clampPaceMs', () {
    test('keeps the default in range', () {
      expect(clampPaceMs(kPaceDefaultMs), kPaceDefaultMs);
    });

    test('clamps faster than 2/sec up to the 500ms floor', () {
      expect(clampPaceMs(100), kPaceMinMs);
      expect(clampPaceMs(0), kPaceMinMs);
    });

    test('clamps slower than 1/5s down to the 5000ms ceiling', () {
      expect(clampPaceMs(99999), kPaceMaxMs);
    });
  });

  group('DownloadProgress', () {
    test('fraction reflects completed/total and handles empty', () {
      const p = DownloadProgress(
        chapterId: 1,
        label: 'Chapter 1',
        total: 4,
        completed: 1,
        status: DownloadStatus.downloading,
      );
      expect(p.fraction, 0.25);
      expect(p.copyWith(completed: 4).fraction, 1.0);

      const empty = DownloadProgress(
        chapterId: 2,
        label: 'Chapter 2',
        total: 0,
        completed: 0,
        status: DownloadStatus.queued,
      );
      expect(empty.fraction, 0);
    });
  });

  group('DownloadState', () {
    test('copyWith preserves untouched fields', () {
      const state = DownloadState();
      expect(state.paceMs, kPaceDefaultMs);
      expect(state.paused, isFalse);

      final paused = state.copyWith(paused: true);
      expect(paused.paused, isTrue);
      expect(paused.paceMs, kPaceDefaultMs);
    });
  });
}
