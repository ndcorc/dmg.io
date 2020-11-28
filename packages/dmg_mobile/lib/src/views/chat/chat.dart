import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'widgets/bottom_bar/bottom_bar.dart';

class Chat extends HookWidget {
  final navKey = GlobalKey<NavigatorState>(debugLabel: 'chat');

  createChannel() => print("Creating Channel ...");

  @override
  Widget build(BuildContext context) {
    final pages = useProvider(routerProvider('chat').state.select((v) => v.pages));
    final config = useProvider(configProvider);

    return Stack(
      children: [
        Navigator(
          key: navKey,
          pages: List.of(pages),
          onPopPage: useProvider(routerProvider('chat')).onPopPage,
        ),
        /* AnimatedPositioned(
          child: BottomBar(),
          bottom: (config.nested.contains(pages.last.name)) ? 0 : -90,
          duration: Duration(milliseconds: 100),
        ) */
      ],
    );
  }
}
