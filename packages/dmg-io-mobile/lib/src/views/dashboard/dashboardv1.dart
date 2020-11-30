import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:row_collection/row_collection.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart' hide Section;
import 'widgetsv1/index.dart';

class Dashboard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    List configs = [
      ["Announcements"],
      ["General", "Notifications"],
      ["Agenda"],
      (isLoading) ? ["Loading"] : ["DMG Connections"]
    ];
    List sections = configs.map((section) => Section(config: section)).toList();
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        children: sections,
      ),
    );
  }
}

/* pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
              builder: DotSwiperPaginationBuilder(size: 20.0, activeSize: 20.0, space: 10.0),
            ), */

/* Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Study Resource",
                            style: theme.textTheme.subtitle1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Card(
                          color: Color(0xFF3F7880),
                          child: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Text("Race & Justice in the Bible",
                                      style: theme.textTheme.subtitle1),
                                  Text("1. The Bible and Race"),
                                  Text("by Tim Keller"),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            "Scripture Memory",
                            style: theme.textTheme.subtitle1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Card(child: Container(height: 200)),
                      ],
                    ),
                  ),
                )
              ],
            ), */

/* Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        children: sections,
      ),
    );
  }
}
*/

class CryptoData {
  static final getData = [
    {
      'name': 'Bitcoin',
      'symbol': 'BTC',
      'icon': Icons.money_rounded,
      'iconColor': Colors.orange,
      'change': '+3.67%',
      'changeValue': '+202.835',
      'changeColor': Colors.green,
      'value': '\$12.279',
    },
    {
      'name': 'Ethereum',
      'symbol': 'ETH',
      'icon': Icons.casino,
      'iconColor': Colors.black,
      'change': '+5.2%',
      'changeValue': '25.567',
      'changeColor': Colors.green,
      'value': '\$7.809'
    },
  ];
}
