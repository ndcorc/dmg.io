import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/models/index.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/utils/extensions/index.dart';
import 'package:dmg_mobile/src/repositories/router.dart';

final routerProvider = StateNotifierProvider.family<RouterCtrl, String>((ref, router) {
  final defaultPage = ref.read(configProvider).getPages(router).first;
  final status = ref.read(authProvider.state).status == Status.Authenticated;
  final startPage = status ? defaultPage : ref.read(configProvider).getPage('intro');
  return RouterCtrl(
    router: router,
    defaultPage: defaultPage,
    startPage: startPage,
    ref: ref,
  );
});

class RouterCtrl extends StateNotifier<Router> {
  RouterCtrl({this.router, this.defaultPage, this.startPage, this.ref})
      : super(Router(
          name: router,
          loaded: true,
          pages: [startPage].toQueue<RoutePage>(),
          history: [startPage.name],
        ));

  final String router;
  final RoutePage<dynamic> defaultPage;
  final RoutePage<dynamic> startPage;
  final ProviderReference ref;

  reset() {
    state = state.copyWith(
      name: router,
      loaded: true,
      history: state.history..clear(),
    );
    ref.read(routerRepoProvider).saveRouter(state);
  }

  Future<bool> push(String name, {Object arguments}) async {
    print('\n');
    print("($router) push($name) ...");
    if (!state.loaded) return false;
    final config = ref.read(configProvider);
    final tempPage = config.getPage(name);
    final newPage = tempPage;
    state = state.copyWith(
      pages: state.pages..add(newPage),
      history: state.history..add(newPage.name),
    );
    ref.read(routerRepoProvider).saveRouter(state);
    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return true;
  }

  Future<bool> pop() async {
    print('\n');
    print("($router) pop() ...");
    if (!state.loaded) return false;
    if (!canPop && router == "root") {
      push("intro");
      return true;
    }
    final newPage = (state.pages..removeLast()).last;
    state = state.copyWith(
      pages: state.pages
        ..removeLast()
        ..add(newPage),
      history: state.history..add(newPage.name),
    );
    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return true;
  }

  Future<bool> add(
    RoutePage page,
    RoutePage afterPage, {
    Object arguments,
  }) async {
    print('\n');
    print("($router) add($page, $afterPage) ...");
    if (!state.loaded) return false;
    final index = state.pages.indexOf(afterPage);
    if (index == -1) return false;
    //final redirect = guard(page);
    final redirect = page;
    state = state.copyWith(
      pages: (state.pages..insert(index + 1, page)) ?? (state.pages..add(redirect)),
      history: state.history..add(page.name),
    );
    ref.read(routerRepoProvider).saveRouter(state);
    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return true;
  }

  Future<bool> remove(RoutePage page) async {
    print('\n');
    print("($router) remove($page) ...");
    if (!state.loaded) return false;
    final index = state.pages.indexOf(page);
    if (index == -1) return false;
    if (index == state.pages.length - 1) return pop();
    state = state.copyWith(pages: state.pages..remove(page));

    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return true;
  }

  Future<bool> pushReplacement(String name, {Object arguments}) async {
    print('\n');
    print("($router) pushReplacement($name) ...");
    if (!state.loaded) return false;
    final page = ref.read(configProvider).getPage(name);
    final start = 0;
    final end = state.pages.length;
    state = state.copyWith(pages: state.pages..replaceRange(start, end, [page]));

    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return true;
  }

  bool onPopPage(Route<dynamic> route, dynamic result) {
    print('\n');
    print("($router) onPopPage($route, $result) ...");
    if (!state.loaded) return false;
    remove(route.settings as RoutePage);

    print("($router) state.pages = ${state.pages.map((v) => v.name)}");
    return route.didPop(result);
  }

  bool get canPop => state.pages.length > 1;

  RoutePage get current => state.pages.last;
}
