/* import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/shared_prefs.dart';
import 'package:dmg_io_mobile/src/models/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'auth.dart';

final routerNameProvider = StateProvider<String>((ref) => null);

final routerFamily = ChangeNotifierProvider.autoDispose.family<Router, String>((ref, router) {
  return Router(router, ref);
});

class Router {
  final GlobalKey<NavigatorState> _navKey;
  final String _router;
  final ProviderReference _ref;
  QueueList<RoutePage> _pages;
  QueueList<RoutePage> _forwards;
  QueueList<RoutePage> _history;

  Router(router, ref)
      : _router = router,
        _ref = ref,
        _navKey = GlobalKey<NavigatorState>(debugLabel: router) {
    _history = QueueList<RoutePage>();
    _forwards = QueueList<RoutePage>();
    load();
  }

  load() async {
    final prefs = await _ref.watch(prefsProvider.future);
    final routes = PageRouter.getRoutes(router);
    List<String> history = prefs.getStringList(router);
    _history = (history.isNull)
        ? QueueList.from([routes[0]])
        : QueueList.from(history.map((p) => PageRouter.getPage(p)));
    RoutePage guarded = guard(_history.last.route);
    if (_history.last.route != guarded.route) _history.add(guarded);
    _pages = QueueList<RoutePage>.from([_history.last]);
  }

  save() async {
    final prefs = await _ref.watch(prefsProvider.future);
    prefs.setStringList(_router, List.from(_history.map((p) => p.route)));
  }

  void push(String name) {
    print("($_router) _pages = $_pages");
    RoutePage page = guard(name);
    _history.add(page);
    _pages.add(page);
    if (_forwards.isNotEmpty) {
      if (_forwards.last == page) _forwards.removeLast();
    }
    /* notifyListeners(); */
  }

  bool pop() {
    print("($_router) _pages = $_pages");
    if (canPop) {
      _forwards.add(_pages.last);
      _pages.removeLast();
      _history.add(_pages.last);
      save();
      /*   notifyListeners(); */
      return true;
    }
    return false;
  }

  bool add(RoutePage page, RoutePage afterPage) {
    print("($_router) _pages = $_pages");
    final index = _pages.indexOf(afterPage);
    if (index == -1) return false;
    _pages.insert(index + 1, page);
    _history.add(page);
    save();
    /*  notifyListeners(); */
    return true;
  }

  bool remove(RoutePage page) {
    print("($_router) _pages = $_pages");
    final index = _pages.indexOf(page);
    if (index == -1) return false;
    _pages.remove(page);
    _forwards.add(_pages.last);
    _history.add(page);
    save();
    /*  notifyListeners(); */
    return true;
  }

  bool onPopPage(Route<dynamic> route, dynamic result) {
    print("($_router) _pages = $_pages");
    remove(route.settings as RoutePage);
    return route.didPop(result);
  }

  RoutePage getPage(String name) => PageRouter.getPage(name);

  RoutePage guard(String name) {
    final isAuth = _ref.watch(authProvider).isAuthenticated;
    return (isAuth) ? getPage(name) : getPage('intro');
  }

  GlobalKey<NavigatorState> get navKey => _navKey;
  String get router => _router;
  bool get canPop => _pages.length > 1;
  bool get ready => _pages != null;
  QueueList<RoutePage> get pages => _pages;
  QueueList<RoutePage> get history => _history;
  QueueList<RoutePage> get forwards => _forwards;
  RoutePage get current => _pages.last;
  RoutePage get next => _forwards.last;
  RoutePage get previous => _pages[_history.length - 2];
}
 */
