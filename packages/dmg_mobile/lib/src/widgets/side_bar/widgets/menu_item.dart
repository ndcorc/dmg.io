import 'dart:ui';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  MenuItem({Key key, this.title, this.active, this.onChanged}) : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;
  final String title;
  int getItemColor() {
    return 0xFF800000 | (this.title.hashCode & 0x000FFFFF).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 60, minWidth: 60),
      padding: EdgeInsets.symmetric(vertical: 0),
      margin: EdgeInsets.symmetric(vertical: 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // You can use like this way
                border: (active == true)
                    ? Border.all(
                        color: Colors.white, //                   <--- border color
                        width: 1.5,
                      )
                    : null,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              duration: Duration(milliseconds: 200),
              child: AnimatedContainer(
                width: 60.0,
                height: 60.0,
                //padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                duration: Duration(milliseconds: 200),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color(getItemColor()),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    this.title,
                    style: TextStyle(
                      height: 1,
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
