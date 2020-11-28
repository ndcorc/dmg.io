import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeProvider = ChangeNotifierProvider((_) => AppTheme());
final String key = "theme";

/// An object that controls the [AppTheme]
class AppTheme extends ChangeNotifier {
  ThemeMode _mode;
  final AppTheme _appThemes = AppTheme();

  AppTheme() {
    loadTheme();
  }

  ThemeMode get mode => _mode;
  ThemeData get light => _appThemes.light;
  ThemeData get dark => _appThemes.dark;

  void loadTheme({String initialTheme}) {
    SharedPreferences.getInstance().then((prefs) {
      final pref = prefs.getInt(key) ?? ThemeMode.system.index;
      _mode = ThemeMode.values[pref];
      print("ThemeMode =  $_mode");
      notifyListeners();
    });
  }

  setTheme(ThemeMode mode) async {
    _mode = mode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, mode.index);
    notifyListeners();
  }
}
