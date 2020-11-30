import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'signin_options.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 0, top: 0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Center(
                  child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
            ),
          ),
          onTap: () => showBarModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            isDismissible: true,
            builder: (_, scrollCtrl) => SignInOptions(scrollCtrl: scrollCtrl),
          ),
        ),
      ),
    );
  }
}
