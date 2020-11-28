import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

extension ThemeDataExt on ThemeData {
  TextStyle get h0 => this.textTheme.h0;
  TextStyle get h1 => this.textTheme.h1;
  TextStyle get h2 => this.textTheme.h2;
  TextStyle get h3 => this.textTheme.h3;
  TextStyle get h4 => this.textTheme.h4;
}

extension TextThemeExt on TextTheme {
  TextStyle get h0 {
    return TextStyle(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get h1 {
    return TextStyle(
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get h2 {
    return TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle get h3 {
    return TextStyle(
      fontSize: 18.0,
      color: Colors.white54,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get h4 {
    return TextStyle(
      fontSize: 14.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get h4focus {
    return TextStyle(
      fontSize: 14.0,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    );
  }
}

extension TextStyleExt on TextStyle {
  TextStyle get focus => this.copyWith(color: Colors.black);
  TextStyle withSize(double size) => this.copyWith(fontSize: size);
}

extension ButtonStyleExt on ButtonStyle {
  ButtonStyle fromState(int index, int tabIndex) {
    if (index == tabIndex) {
      return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.white),
        ),
      );
    } else {
      return ElevatedButton.styleFrom(
        primary: Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.white, width: 5),
        ),
      );
    }
  }

  ButtonStyle enabled() {
    return ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        textStyle: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ));
  }

  ButtonStyle disabled() {
    return ElevatedButton.styleFrom(
      primary: Color(0xFF1A1A1A),
      onPrimary: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.white, width: 5),
      ),
    );
  }
}
