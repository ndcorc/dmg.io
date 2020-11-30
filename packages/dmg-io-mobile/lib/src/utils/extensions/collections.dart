import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

///
/// Iterable Extensions
///
extension IterableExtension<E> on Iterable<E> {
  QueueList<E> toQueue<E>() {
    Iterable q = this;
    return QueueList<E>.from(q);
  }

  bool get isNull => this == null;
}

///
/// List Extensions
///
extension ListExtension<E> on List<E> {
  String get name => describeEnum(this);
  List<T> mapTo<T>(T Function(MapEntry<int, E>) f) => this
      .asMap()
      .entries
      .map(
        (v) => f(v),
      )
      .toList();
  QueueList<E> toQueue<E>() {
    List l = this;
    QueueList<E> q = QueueList<E>();
    return q.fromList(l.cast<E>());
  }

  bool get isNull => this == null;

  void forIn<T>(T Function(MapEntry<int, E>) f) => this.asMap().entries.forEach((v) => f(v));
}

///
/// QueueList Extensions
///
extension QueueListEx<E> on QueueList<E> {
  bool get isNull => this == null;
  bool isEqual(QueueList other) {
    return this.isEqual(other);
  }

  QueueList<T> fromList<T>(List<T> list) {
    QueueList<T> q = QueueList<T>.from(list);
    return q;
  }

  QueueList<T> mapTo<T>(T Function(MapEntry<int, E>) f) => this
      .asMap()
      .entries
      .map(
        (v) => f(v),
      )
      .toQueue();
}

///
/// Map Extensions
///
extension MapExtension on Map {
  Map filter(List keys) => Map.from(this)..removeWhere((key, value) => !keys.contains(key));
  List valueSetBy(List keys) => List.from(Map.from(this).values).map((e) => e.router);
}

///
/// int Extensions
///
extension IntExtension on int {
  void forEach<T>(T Function(MapEntry<int, int>) f) => List<int>.generate(
        this,
        (i) => i + 1,
      ).asMap().entries.forEach((v) => f(v));
}

///
/// Result typedef
///
typedef Result<T> = void Function(
  void Function(T value),
  void Function(Exception value),
  Object _c,
  Object _d,
  Object _e,
  Object _f,
  Object _g,
  Object _h,
  Object _i,
);

T cast<T>(x) => x is T ? x : null;
