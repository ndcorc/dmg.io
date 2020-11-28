import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

MediaQueryData useMedia() {
  return use(
    _MediaQueryHook(),
  );
}

/* Brightness usePlatformBrightness() {
  return use(
    _BrightnessHook(),
  );
} */

class _MediaQueryHook extends Hook<MediaQueryData> {
  const _MediaQueryHook({List<Object> keys}) : super(keys: keys);

  @override
  HookState<MediaQueryData, Hook<MediaQueryData>> createState() =>
      _MediaQueryHookState();
}
/* 
class _BrightnessHook extends Hook<Brightness> {
  const _BrightnessHook({List<Object> keys}) : super(keys: keys);

  @override
  HookState<Brightness, Hook<Brightness>> createState() =>
      _PlatformBrightnessHookState();
} */

class _MediaQueryHookState extends HookState<MediaQueryData, _MediaQueryHook> {
  @override
  MediaQueryData build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery;
  }

  @override
  String get debugLabel => 'useMedia';
}

/* class _PlatformBrightnessHookState
    extends HookState<Brightness, _BrightnessHook> {
  @override
  Brightness build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return brightness;
  }

  @override
  String get debugLabel => 'usePlatformBrightness';
} */
