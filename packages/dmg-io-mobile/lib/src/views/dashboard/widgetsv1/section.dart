import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'index.dart';

class Section extends HookWidget {
  const Section({Key key, this.config}) : super(key: key);
  final List<String> config;

  Widget getChild({String title, AuthCtrl authCtrl, RouterCtrl routerCtrl}) {
    switch (title) {
      case "DMG Connections":
        return Container(child: Connections());
        break;
      case "Loading":
        return LoadingWidget();
        break;
      default:
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 15, bottom: 5),
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: CardSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Dark,
                    isShowAvatar: (config.length == 1) ? true : false,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    padding: EdgeInsets.all(0),
                    barCount: (config.length == 1) ? 3 : 4,
                    backgroundColor: Color(0xFF272727),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = config.asMap().entries.map((c) {
      String section = c.value;
      bool isConn = section == "DMG Connections";
      bool hasSub = config.length > 1;

      final authCtrl = useProvider(authProvider);
      final routerCtrl = useProvider(routerProvider('app'));
      return Expanded(
        child: Container(
          height: !isConn
              ? (config.length > 1)
                  ? 155.0
                  : 180
              : null,
          padding: isConn ? EdgeInsets.all(0) : EdgeInsets.symmetric(horizontal: 5),
          margin: isConn
              ? EdgeInsets.only(bottom: 30)
              : hasSub
                  ? c.key == 0
                      ? EdgeInsets.only(right: 5)
                      : EdgeInsets.only(left: 5)
                  : null,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xFF272727),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              width: 1,
              color: Colors.grey[50].withOpacity(0.2),
            ),
          ),
          child: getChild(title: section, authCtrl: authCtrl, routerCtrl: routerCtrl),
        ),
      );
    }).toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: items,
      ),
    );
  }
}
