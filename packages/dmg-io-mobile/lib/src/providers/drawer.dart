import 'package:flutter/material.dart' hide Drawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:dmg_io_mobile/src/models/drawer.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';

final drawerProvider = StateNotifierProvider((ref) => DrawerCtrl(ref));

class DrawerCtrl extends StateNotifier<Drawer> {
  DrawerCtrl(this.ref)
      : super(
          Drawer(
            vState: ViewState.Idle,
            swipeOffset: 0.0,
            onTapToClose: false,
            swipe: true,
            tapScaffold: true,
            animationType: InnerDrawerAnimation.static,
            offset: 0.8,
            direction: InnerDrawerDirection.start,
            innerDrawerKey: GlobalKey<InnerDrawerState>(),
          ),
        );

  ProviderReference ref;

  set vState(ViewState value) => state = state.copyWith(vState: value);

  set swipeOffset(double value) => state = state.copyWith(swipeOffset: value);

  set onTapToClose(bool value) => state = state.copyWith(onTapToClose: value);

  set swipe(bool value) => state = state.copyWith(swipe: value ?? state.swipe);

  set tapScaffold(bool value) => state = state.copyWith(tapScaffold: value);

  set animationType(InnerDrawerAnimation value) => state = state.copyWith(animationType: value);

  set offset(double value) => state = state.copyWith(offset: value);

  set direction(InnerDrawerDirection value) => state = state.copyWith(direction: value);

  open() => state.innerDrawerKey.currentState.open();

  close() => state.innerDrawerKey.currentState.close();

  toggle() => state.innerDrawerKey.currentState.toggle();

  onDrawerDragUpdate(value, direction) {
    swipeOffset = value;
    print("value = $value");
  }

  onDragUpdate(DragUpdateDetails details) {
    print("offset = ${state.offset.toString()}");

    final config = ref.read(configProvider);
    final appState = ref.read(routerProvider('app')).state;
    final position = details.globalPosition;
    final disableSwipe = config.nested.contains(appState.pages.last.name) ||
        (position.dy > 152 && position.dy < 435);
    this.swipe = (disableSwipe) ? false : true;
    /* print("disabled ${disableSwipe}");
    print("state = ${state.toJson()}"); */
  }
}
