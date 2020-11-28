import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/providers/index.dart';

class Tabs extends HookWidget {
  const Tabs({
    Key key,
    @required this.tabCtrl,
    @required this.config,
    @required this.getPhysics,
    @required this.setPage,
    @required this.getStyle,
  }) : super(key: key);

  final PageController tabCtrl;
  final Configuration config;
  final ScrollPhysics Function() getPhysics;
  final void Function(int index) setPage;
  final ButtonStyle Function(int index) getStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      child: PageView.builder(
        controller: tabCtrl,
        physics: getPhysics(),
        onPageChanged: (int index) => setPage(index),
        itemCount: config.tabTitles.length,
        itemBuilder: (_, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: ElevatedButton(
            style: getStyle(index),
            child: Text(index == 0 ? "Home" : config.tabTitles[index]), //, style: tabTextTheme(0)),
            onPressed: () => (tabCtrl.hasClients) ? setPage(index) : null,
          ),
        ),
      ),
    );
  }
}
