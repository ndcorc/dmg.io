import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'widgets/side_rail.dart';
import 'widgets/side_menu.dart';

class SideBar extends HookWidget {
  SideBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawer = useProvider(drawerProvider);

    final initial = useState(0.0);
    final distance = useState(0.0);
    void reset(details) {
      initial.value = 0.0;
      if (distance.value < 0) drawer.close();
    }

    return GestureDetector(
      onHorizontalDragStart: (details) => initial.value = details.globalPosition.dx,
      onHorizontalDragEnd: reset,
      onHorizontalDragUpdate: (details) {
        distance.value = details.globalPosition.dx - initial.value;
        drawer.swipeOffset = distance.value;
      },
      child: Container(
        child: Row(
          children: [
            SideRail(),
            VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.grey[600],
            ),
            SideMenu()
          ],
        ),
      ),
    );
  }
}
