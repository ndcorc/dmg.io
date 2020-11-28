import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ThemeData useTheme() {
  return use(
    _ThemeHook(),
  );
}

class _ThemeHook extends Hook<ThemeData> {
  const _ThemeHook([List<Object> keys]) : super(keys: keys);

  @override
  HookState<ThemeData, Hook<ThemeData>> createState() => _ThemeHookState();
}

class _ThemeHookState extends HookState<ThemeData, _ThemeHook> {
  @override
  ThemeData build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return themeData;
  }

  @override
  String get debugLabel => 'useTheme';
}
