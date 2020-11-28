import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide Listener;
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'src/views/index.dart';
import 'src/models/index.dart';
import 'src/widgets/index.dart';

class App extends HookWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swipeEnabled = useState(false);
    final auth = useProvider(authProvider.state);
    final drawer = useProvider(drawerProvider);
    final drawerState = useProvider(drawerProvider.state);
    final routerState = useProvider(routerProvider('app').state);
    final config = useProvider(configProvider);

    if (auth.status != Status.Authenticated) return Loading();
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: drawer.onDragUpdate,
        child: InnerDrawer(
            key: drawerState.innerDrawerKey,
            onTapClose: drawerState.onTapToClose,
            tapScaffoldEnabled: drawerState.tapScaffold,
            velocity: 10,
            offset: IDOffset.horizontal(drawerState.offset),
            swipe: drawerState.swipe,
            colorTransitionChild: drawerState.colorTransition,
            colorTransitionScaffold: drawerState.colorTransition,
            leftAnimationType: drawerState.animationType,
            rightAnimationType: InnerDrawerAnimation.linear,
            leftChild: SideBar(),
            scaffold: Scaffold(body: GestureDetector(onTap: drawer.close, child: Home())),
            onDragUpdate: drawer.onDrawerDragUpdate),
      ),
    );
  }
}
