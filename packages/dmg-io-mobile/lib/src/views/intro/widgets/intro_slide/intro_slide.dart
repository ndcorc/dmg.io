import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:union/union.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/models/slide.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'widgets/index.dart';

// ignore: must_be_immutable
class IntroSlide extends HookWidget {
  final Slide slide;
  Union2<SlideTitle, SlideTransition> titleWidget;
  Union2<SlideImage, ScaleTransition> imgWidget;

  IntroSlide({Key key, this.slide}) : super(key: key);

  Alignment getAlignment(index) => (slide.images.length < 2)
      ? Alignment.center
      : (index.isOdd)
          ? Alignment.centerLeft
          : Alignment.centerRight;

  @override
  Widget build(BuildContext _) {
    final intro = useProvider(introProvider);
    final media = useMedia();
    final ctrl = useAnimationController();

    final titleWidget = SlideTitle(slide: slide);
    List<Widget> imgWidgets = slide.images.mapTo((e) {
      return Container(
        child: Flexible(
          child: SlideImage(
            slide: slide,
            index: e.key,
            align: getAlignment(e.key),
          ),
        ),
      );
    });

    useEffect(() {
      if (slide.index != intro.slides.first.index) return;
      if (slide.hasAnimated) return;
      slide.ctrl.forward();
      return null;
    }, [intro.slides.first.animations, intro.currentSlide]);

    useEffect(() {
      if (slide.hasAnimated) return;
      if (slide.index == 0) return;
      slide.setCtrl(ctrl);
      if (slide.index == intro.currentSlide.index) {
        slide.ctrl.forward();
      }
      return null;
    }, [intro.currentSlide]);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: media.titleHeight,
            child: titleWidget,
          ),
          Container(
            height: media.imgsHeight,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [...imgWidgets],
            ),
          )
        ],
      ),
    );
  }
}

/* final intro = useProvider(introProvider);
    bool titleAnimated = (!slide.hasAnimated && slide.index == 0);
    bool imgsAnimated = !slide.hasAnimated;
    Animation titleAnimation = slide.animations.last;
    List imgAnimations = slide.animations.sublist(0, slide.data.images.length);
     */
/* titleWidget = (titleAnimated)
        ? SlideTransition(
            position: _positionTween.animate(titleAnimation),
            child: titleWidget)
        : titleWidget; */
/* imgWidget = imgsAnimated
          ? ScaleTransition(
              scale: _scaleTween.animate(imgAnimations[e.key]),
              child: imgWidget)
          : imgWidget; */
