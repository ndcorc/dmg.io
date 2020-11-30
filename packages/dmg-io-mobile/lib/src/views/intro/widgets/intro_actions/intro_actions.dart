import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/providers/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'widgets/index.dart';

class IntroActions extends HookWidget {
  IntroActions({Key key, this.animations}) : super(key: key);
  final SequenceAnimation animations;

  _buildBase() => Container(
        height: useHeightOf(Section.actions),
        child: Column(
          children: [
            SlideIndicator(),
            GetStarted(),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final intro = useProvider(introProvider);
    final baseWidget = _buildBase();
    return (intro.currentSlide.index == 0 && !intro.currentSlide.hasAnimated)
        ? FadeTransition(
            opacity: intro.currentSlide.animations['actions'],
            child: baseWidget,
          )
        : baseWidget;
  }
}

/*
return Container(
      height: screenHeight * 0.3,
      child: LiveList(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        delay: Duration(milliseconds: 250),
        showItemInterval: Duration(milliseconds: 300),
        showItemDuration: Duration(seconds: 1),
        reAnimateOnVisibility: false,
        visibleFraction: 0.05,
        itemCount: 1,
        itemBuilder: getItemBuilder(
          (j) => Column(
            children: [SlideIndicator(), GetStarted()],
          ),
          padding: EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  } */
