import 'dart:async';
import "package:flutter/foundation.dart";
import 'package:flutter/material.dart' hide Listener;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

AsyncSnapshot<T> useMemoizedFuture<T>(Future<T> future) {
  final memo = useMemoized(() => future);
  final snapshot = useFuture(memo);
  return snapshot;
}

Future<T> useAsyncMemoized<T>(T Function() valueBuilder) async {
  return Future.microtask(() => useMemoized(valueBuilder));
}

void useStateController<T>(
  StateProvider<StateController<T>> provider,
  Listener<T> listener,
) {
  final value = useProvider(provider).state;

  useEffect(() {
    final removeListener = value.addListener(listener);
    return removeListener;
  }, [provider]);
}

void useAsyncEffect(
  FutureOr<dynamic> Function() effect,
  FutureOr<dynamic> Function() cleanup, [
  List<Object> keys,
]) {
  useEffect(() {
    Future.microtask(effect);
    return () {
      if (cleanup != null) {
        Future.microtask(cleanup);
      }
    };
  }, keys);
}

ValueListenable<bool> useIsDisposed() {
  // Yes [useState] returns a ValueNotifier too, but we can't use that – as soon as
  // the useEffect [Dispose] callback is invoked, we can no longer write to it. But
  // we can still read from it, thus why we use it to store our own ValueNotifier.
  final state = useState<ValueNotifier<bool>>()..value ??= ValueNotifier(false);

  useEffect(() {
    return () {
      state.value.value = true;
      state.value.dispose();
    };
  }, []);

  return state.value;
}
