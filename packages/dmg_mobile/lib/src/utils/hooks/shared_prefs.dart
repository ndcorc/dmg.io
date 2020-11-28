import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union/union.dart';

// A custom hook that will read and write values to local storage using the
// SharedPreferences package.
StreamController useSharedPreferences<T>(String key, Union5 s) {
  // Custom hooks can use additional hooks internally!
  final controller = useStreamController<T>(keys: [key]);
  Union5<String, int, bool, double, List<String>> defaultValue = s;

  print(key);
  print(defaultValue.value);
  // Pass a callback to the useEffect hook. Called on first build  or controller/key changes
  useEffect(
    () {
      // Listen to the StreamController, and when a value is added, store it using SharedPrefs.
      final sub = controller.stream.listen((data) async {
        final prefs = await SharedPreferences.getInstance();
        s.value.switchCase(
          (String v) async => await prefs.setString(key, data as String),
          (int v) async => await prefs.setInt(key, data as int),
          (bool v) async => await prefs.setBool(key, data as bool),
          (double v) async => await prefs.setDouble(key, data as double),
          (List<String> v) async => await prefs.setStringList(key, data as List<String>),
        );
      });
      // Unsubscribe when the widget is disposed or on controller/key change
      return sub.cancel;
    },
    // Pass the controller and key to the useEffect hook. This will ensure the useEffect hook is
    // only called the first build or when one of the the values changes.
    [controller, key],
  );

  // Load the initial value from local storage and add it as the initial value to the controller
  useEffect(
    () {
      SharedPreferences.getInstance().then((prefs) async {
        s = await prefs.get(key);
        controller.add(s.value ?? defaultValue.value);
        return;
      }).catchError(controller.addError);
      return;
    },
    // Passing the controller and key as keys ensures the useEffect hook is only called on the
    // first build or controller/key changes
    [controller, key],
  );

  // Finally, return the StreamController. This allows users to add values from the Widget layer
  // and listen to the stream for changes.
  return controller;
}
