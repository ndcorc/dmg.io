import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A custom hook that will read and write values to local storage using the
// SharedPreferences package.
StreamController<T> useLocalStorage<T>(String key, T s) {
  // Custom hooks can use additional hooks internally!
  final controller = useStreamController<T>(keys: [key]);
  T defaultValue = s;

  print(key);
  print(defaultValue);
  // Pass a callback to the useEffect hook. Called on first build and or controller/key changes
  useEffect(
    () {
      // Listen to the StreamController, and when a value is added, store it using SharedPrefs.
      final sub = controller.stream.listen((data) async {
        final prefs = await SharedPreferences.getInstance();
        if (s is String) {
          await prefs.setString(key, data as String);
        } else if (s is int) {
          await prefs.setInt(key, data as int);
        } else if (s is bool) {
          await prefs.setBool(key, data as bool);
        } else if (s is double) {
          await prefs.setDouble(key, data as double);
        } else if (s is List<String>) {
          await prefs.setStringList(key, data as List<String>);
        }
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
        T valueFromStorage;
        if (s is String) {
          valueFromStorage = prefs.getString(key) as T;
        } else if (s is int) {
          valueFromStorage = prefs.getInt(key) as T;
        } else if (s is bool) {
          valueFromStorage = prefs.getBool(key) as T;
        } else if (s is double) {
          valueFromStorage = prefs.getDouble(key) as T;
        } else if (s is List<String>) {
          valueFromStorage = prefs.getStringList(key) as T;
        }

        controller.add(valueFromStorage ?? defaultValue);
      }).catchError(controller.addError);
      return;
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
