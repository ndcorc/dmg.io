import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/views/loading/index.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/services/storage.dart';

class UserAvatar extends HookWidget {
  UserAvatar({Key key, this.sender}) : super(key: key);
  final Map<String, dynamic> sender;

  BoxDecoration avatarBorder(Color color) => BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      );

  @override
  Widget build(BuildContext context) {
    print("sender = $sender");
    //Color primary = sender["color"];
    //Color secondary = primary.withOpacity(0.2);
    //Color icon = sender["inverted"] ? lighten(primary) : primary;
    //Color background = sender["inverted"] ? primary : secondary;
    final user = useProvider(userProvider)?.data?.value;
    final storage = useProvider(storageProvider);
    final member = user.groups[0];

    CircleAvatar avatar;
    AsyncSnapshot url;
    if (member.avatar.url != null || member.avatar.url != "") {
      url = useFuture(storage.downloadUrl(member.avatar.url));
    } else {
      Color iconColor = Color(int.parse(member.avatar.primaryColor));
      Color backgroundColor = Color(
        int.parse(member.avatar.secondaryColor),
      );
      avatar = CircleAvatar(
        backgroundColor: backgroundColor,
        child: Icon(Icons.person, color: iconColor),
      );
    }
    if (avatar == null && url?.data == null) return Loading();
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(0),
      decoration: avatarBorder(Colors.white),
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      child: (avatar == null) ? CircleAvatar(backgroundImage: NetworkImage(url.data)) : avatar,
    );
  }
}
