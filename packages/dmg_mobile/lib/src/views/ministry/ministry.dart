import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:dmg_mobile/src/utils/index.dart' show darkThemeScript;
import 'package:dmg_mobile/src/services/index.dart';
/* import '../children/top_bar.dart';
import 'package:snaplist/snaplist.dart'; */

class Ministry extends HookWidget {
  Ministry({Key key}) : super(key: key);
  static const String route = "/ministry";

  @override
  Widget build(BuildContext context) {
    //final drawer = useProvider(drawerProvider);
    final data = getTreeData();
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: Container(
                    height: 250.0,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFF272727),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      border: Border.all(width: 1, color: Colors.grey[50].withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[400].withOpacity(0.1),
                          spreadRadius: 2.0,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Top Guys",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xFF272727),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(width: 1, color: Colors.grey[50].withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.1),
                  spreadRadius: 2.0,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Echarts(
              extensions: [darkThemeScript],
              theme: 'dark',
              option: '''
              {
                series: [{
                  type: "tree",
                  orient: "vertical",
                  data: ${jsonEncode(data)},
                  symbol: "circle",
                  symbolSize: 10,
                  width: "100%",
                  left: "0%",
                  label: {
                    fontSize: 18,
                    position: "right",
                    color: "rgba(255, 255, 255, 1)"
                  }
                }]
              }
              ''',
            ),
            width: 300,
            height: 250,
          ),
        ),
      ],
    );
  }
}
