import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Router;

import 'package:dmg_mobile/src/utils/index.dart';

import 'route_page.dart';

class Router {
  Router({this.name, this.pages, this.history, this.loaded = false});

  factory Router.fromJson(String source) => Router.fromMap(json.decode(source));

  factory Router.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Router(
      loaded: map['loaded'],
      name: map['name'],
      pages: QueueList<RoutePage>.from(map['pages']),
      history: List<String>.from(map['history']),
    );
  }

  final bool loaded;
  final String name;
  final QueueList<RoutePage> pages;
  final List<String> history;

  @override
  int get hashCode => name.hashCode ^ pages.hashCode ^ loaded.hashCode;

  @override
  bool operator ==(other) =>
      name == other.name && pages.isEqual(other.pages) && loaded == other.loaded;

  @override
  String toString() {
    return 'Router(loaded: $loaded, name: $name, pages: $pages, history: $history)';
  }

  Router copyWith({
    bool loaded,
    String name,
    QueueList<RoutePage> pages,
    List<String> history,
  }) {
    return Router(
      loaded: loaded ?? this.loaded,
      name: name ?? this.name,
      pages: pages ?? this.pages,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loaded': loaded,
      'name': name,
      'pages': pages?.asMap(),
      'history': history,
    };
  }

  String toJson() => json.encode(toMap());
}
