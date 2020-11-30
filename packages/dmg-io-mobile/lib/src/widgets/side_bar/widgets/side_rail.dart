import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/models/index.dart';
import 'package:dmg_io_mobile/src/views/index.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/services/index.dart';
import 'rail_item.dart';

class SideRail extends HookWidget {
  @override
  Widget build(BuildContext context) {
    /*  final railItems = useState(List<NavigationRailDestination>());
    final railData = useState([
      {'title': 'A', 'active': true},
      {'title': 'B', 'active': false},
      {'title': 'C', 'active': false},
    ]);
    final selectedIndex = useState(0);
    final isHovered = useState(false); */

    final router = useProvider(routerProvider('app'));
    final user = useProvider(userProvider)?.data?.value;
    final group = useProvider(groupProvider);

    createGroup() => router.push("dashboard");

    final db = useProvider(databaseProvider);

    return group.when(
        data: (data) {
          List<Widget> groups = List<Widget>.of(user.groups.asMap().entries.map((group) {
            return Container(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.center,
                child: RailItem(
                  user: user,
                  isGroup: true,
                  membership: group.value,
                  changeGroup: db.changeGroup,
                ),
              ),
            );
          }));

          groups.add(Container(
            padding: EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.center,
              child: RailItem(
                user: user,
                isGroup: false,
                createGroup: createGroup,
              ),
            ),
          ));
          return Container(
              width: 100,
              //constraints: BoxConstraints(maxWidth: 72, minWidth: 72),
              child: Container(
                color: Color(0xFF272727),
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 1.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: groups /* user["joinedGroups"] */,
                      ),
                    ),
                  ),
                ),
              ));
        },
        loading: () => Loading(),
        error: (err, trace) => Text(err.toString()));
  }
}
