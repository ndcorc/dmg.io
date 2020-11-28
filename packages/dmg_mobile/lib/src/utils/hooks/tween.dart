/* import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final scale = useState(0);

double useScale(double value, {Duration duration, curve: Curves.easeIn}) {
  final controller = useAnimationController(
    initialValue: value,
    lowerBound: double.negativeInfinity,
    upperBound: double.infinity,
  );

  useValueChanged(value, (_, __) {
    controller.animateTo(value, duration: duration, curve: curve);
  });

  return useAnimation(controller);
}

final Tween<Offset> _positionTween = Tween<Offset>(
    begin: Offset(0, -2.5),
    end: Offset(0, 0),
  ).chain(_positionTween)
  
  
  
  c = CurvedAnimation(
        parent: ctrl,
        curve: Interval(
          start / totalDuration,
          end / totalDuration,
          curve: Curves.easeIn,
        ),
      );]


  animation = new Tween(begin: 0.0, end: 300.0).animate(curve);


animation = new Tween(begin: 0.0, end: 300.0)
  .chain(CurveTween(curve: Interval(
          start / totalDuration,
          end / totalDuration,
          curve: Curves.easeIn,
        ),
      ))
  .animate(ctrl);/*  */ */
