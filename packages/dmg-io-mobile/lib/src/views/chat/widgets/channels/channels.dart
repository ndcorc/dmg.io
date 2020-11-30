import 'package:flutter/material.dart' hide Router;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:dmg_io_mobile/src/views/chat/widgets/bottom_bar/bottom_bar.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/services/index.dart';
import 'package:dmg_io_mobile/src/views/loading/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart' show darkThemeScript;

class Channels extends HookWidget {
  Channels({Key key}) : super(key: key);

  createChannel() => print("Creating Channel ...");

  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('chat'));
    final auth = useProvider(authProvider);
    final hasDrafts = useState(true);
    Map<String, List<String>> chatData = useMemoized(() => getChatData());

    if (chatData == null) return Loading();
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      padding: EdgeInsets.only(bottom: 90, top: 0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height - 165,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            //itemCount: chatItems.length,
            children: [
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
              if (hasDrafts.value)
                ListTile(
                  onTap: () => print("Draft pressed ..."),
                  visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                  leading: Icon(FontAwesome.copy, color: Colors.white, size: 20),
                  title: Text("Drafts", style: TextStyle(color: Colors.white)),
                ),
              ListTile(
                onTap: () => print("Pressed unread ..."),
                title: Text("Unreads", style: TextStyle(color: Colors.white)),
              ),
              ...chatData['unreads'].map(
                (unread) => ListTile(
                  visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                  leading: Icon(
                    FontAwesome.slack,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    unread,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: ListTile(
                    title: Text(
                      "Channels",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () => createChannel(),
                    )),
              ),
              ...chatData['channels'].mapIndexed(
                (channel, index) => ListTile(
                  onTap: () => router.push('channel', arguments: {'channelId': channel}),
                  visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                  leading: Icon(
                    (index != 2 && index != 3) ? FontAwesome.slack : Icons.lock,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    channel,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("New Message ..."),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 5),
            child: Icon(FontAwesome.edit, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
