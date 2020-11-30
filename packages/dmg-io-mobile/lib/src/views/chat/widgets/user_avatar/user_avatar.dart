import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/models/index.dart';

class UserAvatar extends HookWidget {
  const UserAvatar({Key key, this.sender}) : super(key: key);
  final Map<String, dynamic> sender;

  Color lighten(Color color, [double amount = .4]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  @override
  Widget build(BuildContext context) {
    print("sender = $sender");
    /* Color primary = sender["color"];
    Color secondary = primary.withOpacity(0.2);
    Color icon = sender["inverted"] ? lighten(primary) : primary;
    Color background = sender["inverted"] ? primary : secondary; */
    final user = useProvider(userProvider)?.data?.value;
    final group = user.groups[0];

    BoxDecoration avatarBorder(Color color) => BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        );
    CircleAvatar avatar;
    /* if (group.avatar.img != null && group.avatar.img != "") {
      avatar = CircleAvatar(backgroundImage: group.avatar.img);
    } else { */
    Color iconColor = Color(int.parse(group.avatar.primaryColor));
    Color backgroundColor = Color(
      int.parse(group.avatar.secondaryColor),
    );
    avatar = CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(Icons.person, color: iconColor),
    );
    /*   } */
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
