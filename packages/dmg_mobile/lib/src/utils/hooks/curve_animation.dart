import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates and disposes a [CurvedAnimation].
///
/// See also:
/// - [CurvedAnimation]
CurvedAnimation useCurvedAnimation({
  AnimationController ctrl,
  double start,
  double end,
  double duration,
  List<Object> keys,
}) {
  return use(
    _CurvedAnimationHook(
      ctrl: ctrl,
      start: start,
      end: end,
      duration: duration,
      keys: keys,
    ),
  );
}

class _CurvedAnimationHook extends Hook<CurvedAnimation> {
  const _CurvedAnimationHook({
    this.ctrl,
    this.start,
    this.end,
    this.duration,
    List<Object> keys,
  }) : super(keys: keys);

  final AnimationController ctrl;
  final double start;
  final double end;
  final double duration;

  @override
  HookState<CurvedAnimation, Hook<CurvedAnimation>> createState() =>
      _CurvedAnimationHookState();
}

class _CurvedAnimationHookState
    extends HookState<CurvedAnimation, _CurvedAnimationHook> {
  CurvedAnimation curvedAnimaton;

  @override
  CurvedAnimation build(BuildContext context) {
    CurvedAnimation curvedAnimaton = CurvedAnimation(
      parent: hook.ctrl,
      curve: Interval(
        hook.start / hook.duration,
        hook.end / hook.duration,
        curve: Curves.easeIn,
      ),
    );
    return curvedAnimaton;
  }

  @override
  String get debugLabel => 'useCurvedAnimation';
}
