import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/utils/index.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/views/loading/loading.dart';

class SideMenu extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final router = useProvider(routerProvider('app'));
    final routerState = useProvider(routerProvider('app').state);
    final drawer = useProvider(drawerProvider);
    final authCtrl = useProvider(authProvider);
    final user = useProvider(userProvider)?.data?.value;
    final group = useProvider(groupProvider);
    final theme = useTheme();

    // if (user == null) return Loading();

    return group.when(
        data: (group) {
          List menuSections = [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name, style: useTheme().textTheme.h2),
                  Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                  Text(
                    group.domain + ".dmg.io",
                    style: useTheme().textTheme.h3,
                  )
                ],
              ),
            ),
            DefaultTextStyle(
              style: useTheme().h4,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      router.push("dashboard");
                      drawer.close();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.dashboard),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Dashboard"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print("Me"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.face),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Me"),
                        ],
                      ),
                    ),
                  ),
                  /* Padding(
              padding: EdgeInsets.symmetric(vertical:15),
          ), */
                  GestureDetector(
                    onTap: () => print("Members"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.people),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Members"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: useTheme().textTheme.h4,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Chat");
                      if (routerState.pages.last.name != "chat") {
                        router.pushReplacement('chat');
                      }
                      drawer.close();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.message),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 7)),
                          Text("Chat"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      router.push("prayer");
                      drawer.close();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.record_voice_over),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Prayer"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Ministry");
                      router.push('ministry');
                      drawer.close();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Ministry"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DefaultTextStyle(
              style: useTheme().textTheme.h4,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => print("Settings"),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Preferences"),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      drawer.close();
                      try {
                        Future<bool> success = authCtrl.signOut();
                        print("success = $success");
                      } catch (e) {
                        print("Failure to Sign Out and/or navigate to Login: $e");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Text("Sign Out of Texas DMG"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
          return Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.grey[800].withRed(60),
                      Colors.grey[900].withRed(40),
                    ],
                  ),
                ),
                child: Center(
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: menuSections.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        child: menuSections[index],
                      );
                    },
                    separatorBuilder: (context, int index) => const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => Loading(),
        error: (err, trace) => Text(err.toString()));
  }
}
