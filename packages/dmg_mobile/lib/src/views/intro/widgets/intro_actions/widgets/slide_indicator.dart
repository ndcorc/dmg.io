import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/providers/index.dart';
import 'package:dmg_mobile/src/utils/index.dart';

class SlideIndicator extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final intro = useProvider(introProvider);
    int progress = intro.indicator;
    bool isDark = useMedia().platformBrightness == Brightness.dark;
    Color indicatorColor = isDark ? Colors.white : Colors.black;
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: intro.slides.mapTo((slide) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 5.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: progress == slide.key
                  ? indicatorColor.withOpacity(0.9)
                  : indicatorColor.withOpacity(0.3),
            ),
          );
        }),
      ),
    );
  }
}
