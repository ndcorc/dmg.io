import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = FutureProvider((ref) async => await SharedPreferences.getInstance());

final prefsProvider = FutureProvider<Map>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return {
    'routers': {'root': prefs.getStringList('root'), 'app': prefs.getStringList('app')},
    'theme': prefs.getInt('theme')
  };
});
