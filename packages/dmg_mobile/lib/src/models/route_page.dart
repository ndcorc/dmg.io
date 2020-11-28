import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef RouteBuilder<T> = Route<T> Function(BuildContext context, RouteSettings settings);

extension RoutePageEx on RoutePage {
  String get route => (this.path != "/")
      ? this.name.substring(1)
      : (this.router != "root")
          ? "home"
          : "root";
}

enum RouteName { root, home, intro, error, dashboard }
enum RouteStack { root, app }

MaterialPage page;

class RoutePage<T> extends Page<T> {
  RoutePage({
    this.router,
    this.name,
    this.title,
    this.path,
    this.guarded,
    this.child,
    Object arguments,
  }) : super(name: path, key: Key(path), arguments: arguments);

  final Widget child;
  final String name;
  final String title;
  final String path;
  final bool guarded;
  final String router;

  @override
  Route<T> createRoute(_) {
    final Route<T> route = routeBuilder(_, this);
    assert(route.settings == this);
    return route;
  }

  RouteBuilder get routeBuilder =>
      (_, __) => MaterialPageRoute(builder: (_) => child, settings: __);
}
/*
class GuardedRoute<T> extends Page<T> {
  GuardedRoute({
    this.router,
    this.authenticated,
    this.name,
    this.path,
    this.child,
    Object arguments,
  }) {
    super.copyWith()(name: authenticated ? name : , key: ValueKey(path), arguments: arguments);
  }

  final Widget child;
  final String name;
  final String path;
  final String router;
  final bool authenticated;

  @override
  Route<T> createRoute(_) {
    final Route<T> route = routeBuilder(_, this);
    assert(route.settings == this);
    return route;
  }

  RouteBuilder get routeBuilder =>
      (_, __) => MaterialPageRoute(builder: (_) => child, settings: __);
}
 */
