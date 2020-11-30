import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A custom hook that will read and write values to local storage using the
// SharedPreferences package.
StreamController<int> useLocalStorageInt(
  String key, {
  int defaultValue = 0,
}) {
  // Custom hooks can use additional hooks internally!
  final controller = useStreamController<int>(keys: [key]);

  // Pass a callback to the useEffect hook. This function should be called on
  // first build and every time the controller or key changes
  useEffect(
    () {
      // Listen to the StreamController, and when a value is added, store it
      // using SharedPrefs.
      final sub = controller.stream.listen((data) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(key, data);
      });
      // Unsubscribe when the widget is disposed
      // or on controller/key change
      return sub.cancel;
    },
    // Pass the controller and key to the useEffect hook. This will ensure the
    // useEffect hook is only called the first build or when one of the the
    // values changes.
    [controller, key],
  );

  // Load the initial value from local storage and add it as the initial value
  // to the controller
  useEffect(
    () {
      SharedPreferences.getInstance().then((prefs) async {
        final int valueFromStorage = prefs.getInt(key);
        controller.add(valueFromStorage ?? defaultValue);
      }).catchError(controller.addError);
      return null;
    },
    // Pass the controller and key to the useEffect hook. This will ensure the
    // useEffect hook is only called the first build or when one of the the
    // values changes.
    [controller, key],
  );

  // Finally, return the StreamController. This allows users to add values from
  // the Widget layer and listen to the stream for changes.
  return controller;
}
