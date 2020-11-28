import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/models/auth.dart';

final String authKey = "auth";

final authRepoProvider = Provider((ref) => AuthRepo(ref.read));

class AuthRepo {
  AuthRepo(this._read);

  final Reader _read;

  Future<String> loadAuth() async {
    final prefs = await _read(sharedPrefsProvider.future);
    return prefs.getString(authKey);
  }

  Future<bool> saveAuth(Auth auth) async {
    final prefs = await _read(sharedPrefsProvider.future);
    return prefs.setString(authKey, describeEnum(auth.status));
  }
}
