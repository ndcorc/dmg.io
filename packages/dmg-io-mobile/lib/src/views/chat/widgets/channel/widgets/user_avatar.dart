import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';

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
    Color primary = sender["color"];
    Color secondary = primary.withOpacity(0.2);
    Color icon = sender["inverted"] ? lighten(primary) : primary;
    Color background = sender["inverted"] ? primary : secondary;
    final user = useProvider(userProvider)?.data?.value;
    BoxDecoration avatarBorder(Color color) {
      return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(0),
      decoration: avatarBorder(Colors.white),
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        decoration: avatarBorder(background),
        child: Icon(
          Icons.person,
          color: icon,
          size: 38,
        ),
      ),
    );
    /* CircleAvatar(
      backgroundImage: (user['img'] != null) ? user["avatar"]["img"] : null,
      backgroundColor:
          (user['img'] != null) ? null : user["avatar"]["secondary"],
    ); */
  }
}
