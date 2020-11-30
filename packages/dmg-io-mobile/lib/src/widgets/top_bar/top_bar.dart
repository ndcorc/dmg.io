import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:dmg_io_mobile/src/widgets/modals/index.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';

class TopBar extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('app'));
    final routerState = useProvider(routerProvider('app').state);
    final drawer = useProvider(drawerProvider);
    final config = useProvider(configProvider);
    final nested = useState(config.nested.contains(routerState.pages.last.name));
    final theme = useTheme();
    final user = useProvider(userProvider);
    final group = useProvider(groupProvider);

    IconData iconWidget = nested.value ? Icons.arrow_back_ios : Icons.menu;

    return AppBar(
      automaticallyImplyLeading: true,
      //backgroundColor: theme.appBarTheme.color,
      textTheme: Typography.tall2018,
      title: Text(routerState.pages.last.title),
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        iconSize: theme.iconTheme.size,
        icon: Icon(iconWidget),
        onPressed: nested.value ? router.pop : drawer.toggle,
      ),
      actions: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          iconSize: theme.iconTheme.size,
          icon: Icon(Icons.search),
          onPressed: () => showBarModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            isDismissible: true,
            builder: (ctx, scrollCtrl) => SearchModal(
              scrollController: scrollCtrl,
            ),
          ),
        ),
      ],
    );
  }
}

/* Container(
      height: 90,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFF1C1C1C),
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey[50].withOpacity(0.2)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400].withOpacity(0.1),
            spreadRadius: 2.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(0),
              icon: Icon(iconWidget),
              onPressed: nested.value ? routerCtrl.pop : drawer.toggle),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(router.pages.last.title, style: useTheme().textTheme.h0),
              ),
            ),
          ),
          IconButton(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.search),
            onPressed: () => showBarModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              isDismissible: true,
              builder: (context, scrollController) => SearchModal(
                scrollController: scrollController,
              ),
            ),
          ),
        ],
      ),
    ); */
