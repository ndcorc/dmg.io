import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/models/index.dart';
import 'package:dmg_mobile/src/providers/index.dart';

class RailItem extends HookWidget {
  RailItem({
    Key key,
    this.isGroup,
    this.user,
    this.membership,
    this.changeGroup,
    this.createGroup,
  }) : super(key: key);

  final bool isGroup;
  final User user;
  final Membership membership;
  final Future<void> Function(User, String) changeGroup;
  final Future<bool> Function() createGroup;

  Color colorFor(String text) {
    var hash = 0;
    for (var i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }
    final finalHash = hash.abs() % (256 * 256 * 256);
    final red = ((finalHash & 0xFF0000) >> 16);
    final blue = ((finalHash & 0xFF00) >> 8);
    final green = ((finalHash & 0xFF));
    final color = Color.fromRGBO(red, green, blue, 1);
    return color;
  }

  Icon createIcon = Icon(Icons.add);
  String getAbbr() {
    List<String> names = membership.groupName.split(" ");
    List abbr = [];
    for (var i = 0; i < names.length; i++) {
      if (abbr.length > 2) return abbr.join();
      if (isAlpha(names[i][0])) abbr.add('${names[i][0]}');
    }
    return abbr.join();
  }

  bool hasBorder() {
    if (isGroup == false) return true;
    if (membership.gid == user.currentGroup) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final drawer = useProvider(drawerProvider);
    final routerCtrl = useProvider(routerProvider('root'));
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: (hasBorder() == true)
                    ? Border.all(color: Colors.white.withOpacity(0.6), width: 3)
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              duration: Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: (isGroup) ? colorFor(membership.displayName) : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (isGroup && membership.displayName != user.currentGroup) {
                        changeGroup(user, membership.gid);
                        drawer.close();
                        routerCtrl.push('dashboard');
                      } else {
                        createGroup();
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: (isGroup)
                          ? Text(
                              getAbbr(),
                              style: TextStyle(
                                height: 1,
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : createIcon,
                    ),
                  ),
                ),
              ),
            ),
            if (isGroup)
              Container(
                //width: 70,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: EdgeInsets.only(bottom: 10, top: 1),
                child: Text(
                  membership.groupName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
          ]),
    );
  }
}
