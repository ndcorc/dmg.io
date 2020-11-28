import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/models/index.dart';
import 'package:dmg_mobile/src/providers/index.dart';

final routerRepoProvider = Provider((ref) => RouterRepo(ref.read));

class RouterRepo {
  RouterRepo(this.read);

  final Reader read;

  Future<List<String>> loadPages(Router state) async {
    final prefs = await read(sharedPrefsProvider.future);
    return prefs.getStringList(state.name);
  }

  Future<bool> saveRouter(Router state) async {
    final prefs = await read(sharedPrefsProvider.future);
    return prefs.setStringList(state.name, state.history);
  }
}
