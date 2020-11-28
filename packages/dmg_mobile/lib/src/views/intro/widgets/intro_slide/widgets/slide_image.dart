import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dmg_mobile/src/utils/index.dart';
import 'package:dmg_mobile/src/models/slide.dart';

class SlideImage extends HookWidget {
  SlideImage({
    Key key,
    this.align,
    this.slide,
    this.index,
  }) : super(key: key);
  final Alignment align;
  final Slide slide;
  final int index;

  _buildBase(imgHeight) => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: align,
        width: useMedia().width,
        child: Image(
          height: imgHeight,
          image: AssetImage(slide.images[index]),
          fit: BoxFit.contain,
        ),
      );

  @override
  Widget build(BuildContext context) {
    /* final animation = useAnimation(useProvider(
      introProvider.select((p) => p.currentSlide.ctrl),
    )); */
    final imgHeight = useMedia().imgHeight(slide.images.length);
    final baseWidget = _buildBase(imgHeight);

    return (!slide.hasAnimated)
        ? ScaleTransition(
            scale: slide.animations['image$index'],
            child: baseWidget,
          )
        : baseWidget;
  }
}
