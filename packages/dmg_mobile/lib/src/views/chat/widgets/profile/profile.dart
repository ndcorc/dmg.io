import 'package:flutter/material.dart';
import 'package:jdenticon/jdenticon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/models/index.dart';

class Profile extends HookWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authProvider);
    final user = useProvider(userProvider)?.data?.value;
    final currentGroup = user?.groups?.singleWhere((g) => g.displayName == user.currentGroup);
    //print(user.data);
    var rawSvg = Jdenticon.toSvg(user.email, 100);
    Widget identicon = SvgPicture.string(
      rawSvg,
      fit: BoxFit.fill,
      height: 50,
      width: 50,
    );
    return Container(
      height: MediaQuery.of(context).size.height - 90,
      margin: EdgeInsets.symmetric(vertical: 0),
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Badge(
                    position: BadgePosition.bottomEnd(bottom: 16, end: 0),
                    badgeColor: Colors.transparent,
                    badgeContent: Container(
                      //padding: ,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[800].withRed(60),
                            spreadRadius: 2.5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.notifications_paused,
                        color: Colors.green,
                        size: 13,
                      ),
                    ),
                    child: Badge(
                      position: BadgePosition.bottomEnd(bottom: 6, end: 10),
                      badgeContent: Container(
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[800].withRed(60),
                              spreadRadius: 5.0,
                              offset: Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      badgeColor: Colors.transparent,
                      child: Container(
                        child: identicon,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        margin: EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentGroup.displayName, style: TextStyle(fontSize: 18)),
                          Text(
                            "Active",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 20, left: 15, right: 15),
              child: Center(
                child: InkWell(
                  child: Container(
                    //height: 90,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[500]),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.sentiment_satisfied, color: Colors.white),
                          ),
                          Text(
                            "What's your status?",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () => print("Jumping to ..."),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey[50].withOpacity(0.2),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.do_not_disturb,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("Do not disturb"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.phonelink_off,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("Set yourself as away"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.grey[50].withOpacity(0.2),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("Saved items"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("View profile"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("Notifications"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 20),
                          child: Text("Preferences"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
