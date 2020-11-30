import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';

final String key = "theme";

final themeRepoProvider = Provider((ref) => ThemeRepo(ref.read));

class ThemeRepo {
  ThemeRepo(this._read);

  final Reader _read;

  Future<int> loadMode() async {
    final prefs = await _read(sharedPrefsProvider.future);
    return prefs.getInt(key);
  }

  Future<bool> saveMode(ThemeMode mode) async {
    final prefs = await _read(sharedPrefsProvider.future);
    return prefs.setInt(key, mode.index);
  }
}
