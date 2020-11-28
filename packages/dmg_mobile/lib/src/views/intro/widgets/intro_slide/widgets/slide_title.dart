import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/models/slide.dart';

class SlideTitle extends HookWidget {
  SlideTitle({Key key, this.slide}) : super(key: key);

  final Slide slide;
  String getBolded() {
    switch (slide.index) {
      case 0:
        return "All your team communication";
      case 1:
        return "personal ministry";
      case 2:
        return "prayer lists";
      case 3:
        return "Getting started is easy!";
      default:
        return "error";
    }
  }

  _buildBase(parts) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40),
      child: Text.rich(TextSpan(children: parts), textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    String boldText = getBolded();
    List<TextSpan> parts = slide.text.split(boldText).map((part) => TextSpan(text: part)).toList()
      ..insert(
          1,
          TextSpan(
            text: boldText,
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
    Widget baseWidget = _buildBase(parts);
    /* final animation = useAnimation(
      useProvider(introProvider.select((p) => p.currentSlide.ctrl)),
    ); */
    return (slide.index == 0 && !slide.hasAnimated)
        ? SlideTransition(
            position: slide.animations['title'],
            child: baseWidget,
          )
        : baseWidget;
/*     return (slide.index == 0 && !slide.hasAnimated)
        ? AnimatedBuilder(
            builder: (ctx, child) => SlideTransition(
              position: slide.animations['title'],
              child: baseWidget,
            ),
            animation: useProvider(
              introProvider.select((p) => p.currentSlide.ctrl),
            ),
          )
        : baseWidget; */
  }
}
