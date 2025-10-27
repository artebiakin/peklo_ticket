import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:go_router/go_router.dart';

CustomTransitionPage bloodTransitionPage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(seconds: 3),
    reverseTransitionDuration: Duration.zero,
    maintainState: false,
    transitionsBuilder: (context, animation, secondary, child) =>
        _BloodMaskReveal(progress: animation, child: child),
  );
}

abstract class _BloodBase extends StatefulWidget {
  final Animation<double> progress;
  const _BloodBase({required this.progress});
}

abstract class _BloodBaseState<T extends _BloodBase> extends State<T>
    with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  late final Ticker _ticker;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      _time = elapsed.inMicroseconds / 1e6;
      if (mounted) setState(() {});
    })
      ..start();
    _load();
    widget.progress.addListener(_onAnim);
  }

  void _onAnim() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    _program = await ui.FragmentProgram.fromAsset('assets/shaders/wave.frag');
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant _BloodBase oldWidget) {
    super.didUpdateWidget(oldWidget as T);
    if (oldWidget.progress != widget.progress) {
      oldWidget.progress.removeListener(_onAnim);
      widget.progress.addListener(_onAnim);
    }
  }

  @override
  void dispose() {
    widget.progress.removeListener(_onAnim);
    _ticker.dispose();
    super.dispose();
  }

  ui.FragmentShader? _shader(Size size) {
    if (_program == null) return null;
    final s = _program!.fragmentShader();
    // GLSL indices: 0:uSize.x 1:uSize.y 2:uT 3:uTime 4:uFeather 5:uDripAmp 6:uBlobAmp
    s.setFloat(0, size.width);
    s.setFloat(1, size.height * 4);
    s.setFloat(2, widget.progress.value);
    s.setFloat(3, _time);
    s.setFloat(4, 80.0); // feather softness
    s.setFloat(5, 1.9); // drip intensity
    s.setFloat(6, 10.9); // blobby edge
    return s;
  }
}

class _BloodMaskReveal extends _BloodBase {
  final Widget child;
  const _BloodMaskReveal({required super.progress, required this.child});
  @override
  State<_BloodMaskReveal> createState() => _BloodMaskRevealState();
}

class _BloodMaskRevealState extends _BloodBaseState<_BloodMaskReveal> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final shader = _shader(c.biggest);
      if (shader == null) return widget.child;
      return ShaderMask(
        blendMode: BlendMode.dstOut, // reveal child where mask alpha=1
        shaderCallback: (_) => shader,
        child: widget.child,
      );
    });
  }
}
