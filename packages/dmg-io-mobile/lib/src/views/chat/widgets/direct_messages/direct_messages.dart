import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/services/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'widgets/user_avatar.dart';

class DMs extends HookWidget {
  const DMs({Key key}) : super(key: key);

  createChannel() => print("Creating Channel ...");

  List buildDMs(List<Map<String, dynamic>> dms) {
    List<ListTile> dmItems = List();
    dms.forEach((dm) {
      Map<String, String> last = dm['lastMessage'];
      print("last = $last");
      Random random = Random();
      Map<String, dynamic> sender = {
        "color": colorFor(dm["userName"]),
        "inverted": !random.nextBool()
      };
      dmItems.add(
        ListTile(
          visualDensity: VisualDensity(vertical: -3, horizontal: -4),
          leading: UserAvatar(sender: sender),
          title: Text(dm["userName"]),
          subtitle: Text("${last["sender"]}: ${last["message"]}"),
          trailing: Text(last["time"]),
        ),
      );
    });
    return dmItems;
  }

  @override
  Widget build(BuildContext context) {
    final nav = useProvider(routerProvider('app'));
    final auth = useProvider(authProvider);
    final hasDrafts = true;

    List dms = buildDMs(getMockData());

    List chatItems = [
      StickyHeader(
        overlapHeaders: true,
        header: Center(
          child: InkWell(
            child: Container(
              height: 90,
              margin: EdgeInsets.only(bottom: 10),
              child: FractionallySizedBox(
                widthFactor: 0.925,
                heightFactor: 0.7,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[500]),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Jump to...', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            onTap: () => print("Jumping to ..."),
          ),
        ),
        content: Container(
          padding: EdgeInsets.only(top: 70),
          margin: EdgeInsets.only(top: 0),
          child: ListTile(
            onTap: () => print("Threads pressed ..."),
            visualDensity: VisualDensity(vertical: -4, horizontal: -4),
            leading: Icon(Icons.insert_comment, color: Colors.white, size: 20),
            title: Text("Threads", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ];
    chatItems.addAll(dms);
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      padding: EdgeInsets.only(bottom: 90, top: 0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height - 165,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              itemCount: chatItems.length,
              itemBuilder: (_, i) => chatItems[i],
              separatorBuilder: (_, i) => Divider(color: Colors.black)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("New Message ..."),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              FontAwesome.edit,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
