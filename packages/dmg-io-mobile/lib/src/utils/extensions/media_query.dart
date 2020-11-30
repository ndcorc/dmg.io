import 'package:flutter/material.dart';

final double factor = 0.7;
final double remainder = 0.3;

extension MediaQueryDataExtension on MediaQueryData {
  double get height => this.size.height;
  double get width => this.size.width;
  Brightness get brightness => this.platformBrightness;
  double get slideHeight => this.size.height * factor;
  double get actionsHeight => this.size.height * remainder;
  double get imgsHeight => this.size.height * factor * factor;
  double get titleHeight => this.size.height * factor * remainder;
  double imgHeight(int count) => (this.size.height * factor * factor) / count;
}
