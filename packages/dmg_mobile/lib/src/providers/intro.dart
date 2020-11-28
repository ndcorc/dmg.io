import 'package:dmg_mobile/src/models/slide.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_mobile/src/services/index.dart';
import 'package:dmg_mobile/src/utils/index.dart';

extension DurationExtension on Duration {
  double get secs => this.inSeconds.toDouble();
}

final introProvider = ChangeNotifierProvider((_) => IntroState());

class IntroState extends ChangeNotifier {
  List<Slide> _slides;
  Slide _currentSlide;
  //Duration _duration;
  List<AnimationController> _ctrls;
  AnimationController _firstCtrl;
  int _indicator = 0;
  bool animationsSet = false;

  IntroState() {
    loadIntro();
    _currentSlide = _slides[0];
  }

  List<Slide> get slides => _slides;
  Slide get currentSlide => _currentSlide;
  AnimationController get firstCtrl => _firstCtrl;
  //Duration get duration => _duration;
  List<AnimationController> get ctrls => _ctrls;
  int get indicator => _indicator;

  void setCurrentSlide(index) {
    _currentSlide.setHasAnimated(true);
    _currentSlide = slides[index];
    notifyListeners();
  }

  void setIndicator(page) {
    _indicator = page;
    notifyListeners();
  }

  setFirstCtrl(ctrl) {
    _firstCtrl = ctrl;
    Slide first = _slides.removeAt(0);
    first.setCtrl(firstCtrl);
    _slides.insert(0, first);
  }

  /* void setCtrl(ctrl) {
    _ctrls = ctrls;
    if (_currentSlide.ctrl != null) return;
    /* if (animationsSet) return; */
    _slides[_currentSlide.index].setAnimations(ctrl);
    /* ctrls.forIn((ctrl) {
      _slides[ctrl.key].setAnimations(ctrl.value);
    }); */
    //_currentSlide.setAnimations(ctrl);
  } */

  void loadIntro() {
    _slides = data.mapTo((slide) {
      Slide _slide = Slide.fromMap({
        ...slide.value,
        'index': slide.key,
      });
      _slide.buildAnimations();
      return _slide;
    });
    /* _duration = Duration(
      seconds: _slides.mapTo((slide) => slide.value.images.length).reduce(max),
    ); */
  }
}
