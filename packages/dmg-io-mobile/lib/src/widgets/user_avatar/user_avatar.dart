/* import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/models/index.dart';
//import 'package:dmg_io_mobile/utils/getters.dart';
import 'dart:math';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key key, this.name}) : super(key: key);
  final String name;

  Color getPrimary() => colorFor(name);

  Color lighten(Color color, [double amount = .4]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  @override
  Widget build(BuildContext context) {
    bool isInverted = Random().nextBool();
    Color primary = getPrimary();
    Color secondary = lighten(primary);
    Color icon = isInverted ? primary : secondary;
    Color background = isInverted ? secondary : primary;
    //final user = useProvider(userProvider)?.data?.value.data;

    final group = user['groups'][0];
    print("user.keys = ${user.keys}");

    BoxDecoration avatarBorder(Color color) => BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        );
    CircleAvatar avatar;
    if (group["avatar"]["img"] != null && group["avatar"]["img"] != "") {
      avatar = CircleAvatar(backgroundImage: group["avatar"]["img"]);
    } else {
      Color iconColor = icon;
      Color backgroundColor = background;
      avatar = CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(Icons.person, color: iconColor),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(0),
      decoration: avatarBorder(Colors.white),
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      child: avatar,
    );
  }
}
 */
