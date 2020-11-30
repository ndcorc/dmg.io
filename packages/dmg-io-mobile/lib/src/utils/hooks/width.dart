import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

double useWidth() {
  return use(
    _ScreenWidthHook(),
  );
}

class _ScreenWidthHook extends Hook<double> {
  const _ScreenWidthHook({List<Object> keys}) : super(keys: keys);

  @override
  HookState<double, Hook<double>> createState() => _ScreenWidthHookState();
}

class _ScreenWidthHookState extends HookState<double, _ScreenWidthHook> {
  @override
  double build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  @override
  String get debugLabel => 'useWidth';
}
