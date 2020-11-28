import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

enum ViewState { Idle, Busy }

class Drawer {
  Drawer({
    ViewState vState,
    double swipeOffset,
    bool swipe,
    bool tapScaffold,
    bool onTapToClose,
    InnerDrawerAnimation animationType,
    double offset,
    InnerDrawerDirection direction,
    GlobalKey<InnerDrawerState> innerDrawerKey,
  })  : _vState = vState,
        _swipeOffset = swipeOffset,
        _swipe = swipe,
        _tapScaffold = tapScaffold,
        _onTapToClose = onTapToClose,
        _animationType = animationType,
        _offset = offset,
        _direction = direction,
        _innerDrawerKey = innerDrawerKey;

  factory Drawer.fromJson(String source) => Drawer.fromMap(json.decode(source));

  factory Drawer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Drawer(
      vState: ViewState.values[map['vState']],
      swipeOffset: map['swipeOffset'],
      swipe: map['swipe'],
      tapScaffold: map['tapScaffold'],
      onTapToClose: map['onTapToClose'],
      offset: map['offset'],
    );
  }

  final InnerDrawerAnimation _animationType;
  final Color _colorTransition = Colors.black.withOpacity(0.8);
  final InnerDrawerDirection _direction;
  final double _offset;
  final bool _onTapToClose;
  final bool _swipe;
  final double _swipeOffset;
  final bool _tapScaffold;
  final ViewState _vState;
  final GlobalKey<InnerDrawerState> _innerDrawerKey;

  InnerDrawerAnimation get animationType => _animationType;
  Color get colorTransition => _colorTransition;
  InnerDrawerDirection get direction => _direction;
  double get offset => _offset;
  bool get onTapToClose => _onTapToClose;
  bool get swipe => _swipe;
  double get swipeOffset => _swipeOffset;
  bool get tapScaffold => _tapScaffold;
  ViewState get vState => _vState;
  GlobalKey<InnerDrawerState> get innerDrawerKey => _innerDrawerKey;
  /*  @override
  String toString() {
    return 'Drawer(_state: $vState, swipeOffset: $swipeOffset, swipe: $swipe, tapScaffold: $tapScaffold, onTapToClose: $onTapToClose, animationType: $animationType, offset: $offset, direction: $direction)';
  } */

  Drawer copyWith({
    InnerDrawerAnimation animationType,
    InnerDrawerDirection direction,
    double offset,
    bool onTapToClose,
    bool swipe,
    double swipeOffset,
    bool tapScaffold,
    ViewState vState,
    GlobalKey<InnerDrawerState> innerDrawerKey,
  }) {
    return Drawer(
      animationType: animationType ?? _animationType,
      direction: direction ?? _direction,
      offset: offset ?? _offset,
      onTapToClose: onTapToClose ?? _onTapToClose,
      swipe: swipe ?? _swipe,
      swipeOffset: swipeOffset ?? _swipeOffset,
      tapScaffold: tapScaffold ?? _tapScaffold,
      vState: vState ?? _vState,
      innerDrawerKey: innerDrawerKey ?? _innerDrawerKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vState': _vState?.index,
      'swipeOffset': _swipeOffset,
      'swipe': _swipe,
      'tapScaffold': _tapScaffold,
      'onTapToClose': _onTapToClose,
      /* 'animationType': animationType.toMap(), */
      'offset': _offset,
    };
  }

  String toJson() => json.encode(toMap());
}
