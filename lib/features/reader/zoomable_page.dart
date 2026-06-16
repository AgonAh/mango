import 'package:flutter/material.dart';

/// A single full-screen page that supports pinch zoom and a double-tap toggle
/// between fully zoomed out (fit) and +50% (1.5x) centered on the tap point.
///
/// Reports its zoom state upward so the reader can gate page swiping: paging is
/// only allowed while fully zoomed out.
class ZoomablePage extends StatefulWidget {
  const ZoomablePage({
    super.key,
    required this.provider,
    required this.onZoomChanged,
    required this.onTap,
  });

  final ImageProvider provider;
  final ValueChanged<bool> onZoomChanged;
  final VoidCallback onTap;

  @override
  State<ZoomablePage> createState() => _ZoomablePageState();
}

class _ZoomablePageState extends State<ZoomablePage>
    with SingleTickerProviderStateMixin {
  static const double _zoomScale = 1.5;

  final TransformationController _tc = TransformationController();
  late final AnimationController _anim;
  Animation<Matrix4>? _animation;
  Offset _doubleTapPosition = Offset.zero;
  bool _zoomed = false;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        final value = _animation?.value;
        if (value != null) _tc.value = value;
      });
    _tc.addListener(_handleTransform);
  }

  void _handleTransform() {
    final scale = _tc.value.getMaxScaleOnAxis();
    final zoomed = scale > 1.01;
    if (zoomed != _zoomed) {
      _zoomed = zoomed;
      widget.onZoomChanged(zoomed);
    }
  }

  void _handleDoubleTap() {
    final currentlyZoomed = _tc.value.getMaxScaleOnAxis() > 1.01;
    final Matrix4 target;
    if (currentlyZoomed) {
      target = Matrix4.identity();
    } else {
      final x = -_doubleTapPosition.dx * (_zoomScale - 1);
      final y = -_doubleTapPosition.dy * (_zoomScale - 1);
      target = Matrix4.identity()
        ..translate(x, y)
        ..scale(_zoomScale);
    }
    _animation = Matrix4Tween(begin: _tc.value, end: target)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward(from: 0);
  }

  @override
  void dispose() {
    _anim.dispose();
    _tc.removeListener(_handleTransform);
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTapDown: (d) => _doubleTapPosition = d.localPosition,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _tc,
        minScale: 1,
        maxScale: 4,
        child: SizedBox.expand(
          child: Image(
            image: widget.provider,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stack) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white24, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}
