import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CardSkeleton(
            style: SkeletonStyle(
              theme: SkeletonTheme.Dark,
              isShowAvatar: true,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              padding: EdgeInsets.only(bottom: 10),
              barCount: 3,
              backgroundColor: Color(0xFF272727),
            ),
          ),
          CardSkeleton(
            style: SkeletonStyle(
              theme: SkeletonTheme.Dark,
              isShowAvatar: false,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              padding: EdgeInsets.only(top: 10),
              barCount: 3,
              backgroundColor: Color(0xFF272727),
            ),
          ),
        ],
      ),
    );
    /* return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(0),
              child: Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(0xFF272727),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey[50].withOpacity(0.2),
                  ),
                ),
                child: 
                //child: getGraphView(size)),
              ),
            ),
          ),
        ],
      ),
    ); */
  }
}
