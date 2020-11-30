import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'package:dmg_io_mobile/src/utils/extensions/index.dart';

class Slide {
  final String _text;
  final List<String> _images;
  final int _index;
  final int _duration = 500;
  final int _buffer = 100;
  final Tween<double> _scaleTween = Tween<double>(begin: 0, end: 1);
  final Tween<Offset> _positionTween = Tween<Offset>(
    begin: Offset(0, -2.5),
    end: Offset(0, 0),
  );
  final Tween<double> _opacityTween = Tween<double>(begin: 0, end: 1);
  SequenceAnimationBuilder _animationSequence = SequenceAnimationBuilder();
  SequenceAnimation _animations;
  AnimationController _ctrl;
  bool _hasAnimated = false;
  int _epoch = 0;
  Tween<double> get scaleTween => _scaleTween;
  Tween<Offset> get positionTween => _positionTween;
  Tween<double> get opacityTween => _opacityTween;
  Map<String, Tween<dynamic>> get tweens => {
        "actions": _opacityTween,
        "title": _positionTween,
        "image": _scaleTween,
      };

  Slide(
    String text,
    List<String> images,
    int index, {
    SequenceAnimation animations,
    AnimationController ctrl,
    bool hasAnimated,
    int epoch,
  })  : _text = text,
        _images = images,
        _index = index {
    if (animations != null) _animations = animations;
    if (ctrl != null) _ctrl = ctrl;
    if (hasAnimated != null) _hasAnimated = hasAnimated;
    if (epoch != null) _epoch = epoch;
  }

  factory Slide.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Slide(
      map['text'],
      List<String>.from(map['images']),
      map['index'],
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'images': images,
        'index': index,
      };

  Slide copyWith({
    String text,
    List<String> images,
    int index,
    SequenceAnimation animations,
    AnimationController ctrl,
    bool hasAnimated,
    int epoch,
  }) {
    return Slide(
      text ?? _text,
      images ?? _images,
      index ?? _index,
      animations: animations ?? _animations,
      ctrl: ctrl ?? _ctrl,
      hasAnimated: hasAnimated ?? _hasAnimated,
      epoch: epoch ?? _epoch,
    );
  }

  setCtrl(ctrl) {
    _ctrl = ctrl;
    _animations = _animationSequence.animate(ctrl);
  }

  setHasAnimated(status) => _hasAnimated = status;

  buildAnimations() {
    final animatables = List.from(images).mapTo(
      (i) => ['image', '${i.key}'],
    );
    if (index == 0) animatables..add(['title'])..add(['actions']);
    animatables.forIn((a) {
      List<String> av = a.value;
      _animationSequence = _animationSequence.addAnimatable(
        animatable: tweens[av.first],
        from: Duration(milliseconds: _epoch),
        to: Duration(milliseconds: _epoch + _duration),
        tag: av.first + (av.length > 1 ? av.last : ''),
        curve: Curves.easeIn,
      );
      _epoch += _duration + _buffer;
    });
  }

  String get text => _text;
  List<String> get images => _images;
  int get index => _index;
  AnimationController get ctrl => _ctrl;
  SequenceAnimation get animations => _animations;
  bool get hasAnimated => _hasAnimated;
}
