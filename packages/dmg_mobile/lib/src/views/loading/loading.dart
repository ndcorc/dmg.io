import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends HookWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AnimationController ctrl = useAnimationController(duration: Duration(seconds: 2));
    //  print("ctrl $ctrl");
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey[800].withRed(60),
              Colors.grey[900].withRed(40),
            ],
          ),
        ),
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 100.0,
          //controller: ctrl,
        ),
      ),
    );
  }
}
