import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'widgets/index.dart';

class Dashboard extends HookWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = useHeight() * 0.9;
    final apFraction = 0.01;
    final dFraction = apFraction * 0.1;

    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          MainSection(),
          Divider(height: height * dFraction),
          ContentSection(),
          Divider(height: height * dFraction),
          DataSection(),
        ],
      ),
    );
  }
}
