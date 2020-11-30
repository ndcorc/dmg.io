import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Section { slide, actions, images, title }

final double ff = 0.7;
final double rr = 0.3;

double useHeight() {
  return use(
    _ScreenHeightHook(),
  );
}

double useHeightOf([Section section]) {
  return use(
    _ScreenHeightHook(section),
  );
}

class _ScreenHeightHook extends Hook<double> {
  const _ScreenHeightHook([this.section, List<Object> keys])
      : super(keys: keys);

  final Section section;

  @override
  HookState<double, Hook<double>> createState() => _ScreenHeightHookState();
}

class _ScreenHeightHookState extends HookState<double, _ScreenHeightHook> {
  @override
  double build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (hook.section == null) return screenHeight;
    switch (hook.section) {
      case Section.slide:
        return screenHeight * ff;
        break;
      case Section.actions:
        return screenHeight * rr;
        break;
      case Section.images:
        return screenHeight * ff * ff;
        break;
      case Section.title:
        return screenHeight * ff * rr;
      default:
        return screenHeight;
    }
  }

  @override
  String get debugLabel => 'useHeight';
}
