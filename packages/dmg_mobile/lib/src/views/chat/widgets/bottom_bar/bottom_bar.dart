import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/utils/hooks/index.dart';

class BottomBar extends HookWidget {
  final viewVisible = useState(true);
  final active = useState(0);

  Widget build(BuildContext context) {
    double screenWidth = useWidth();
    final router = useProvider(routerProvider('app'));
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90,
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color(0xFF272727),
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey[50].withOpacity(0.2)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400].withOpacity(0.1),
              spreadRadius: 2.0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: useProvider(configProvider).bottomBarItems.asMap().entries.map(
            (item) {
              return GestureDetector(
                onTap: () {
                  active.value = item.key;
                  router.push(item.value['route']);
                },
                child: Container(
                  alignment: Alignment.topCenter,
                  //height: 100,
                  //width: MediaQuery.of(context).size.width / 5,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF272727),
                    border: Border.all(color: Colors.transparent, width: 0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5, top: 10),
                        //constraints: BoxConstraints(maxWidth: 10),
                        //margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          (active.value == item.key)
                              ? item.value["icon"][0]
                              : item.value["icon"][1],
                        ),
                      ),
                      Container(
                        //margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(item.value["text"],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color:
                                    (active.value == item.key) ? Colors.white : Colors.grey[500])),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
        //),
      ),
    );
  }
}
