import 'dart:convert';
import 'package:flutter/material.dart';


class AppTheme {
  AppTheme({this.mode, this.dark, this.light, this.loading});

  factory AppTheme.fromJson(String source) => AppTheme.fromMap(json.decode(source));

  factory AppTheme.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppTheme(
      mode: ThemeMode.values[map['mode']],
    );
  }

  final bool loading;

  final ThemeData dark;

  final ThemeData light;

  final ThemeMode mode;

  //ThemeData get data => mode == ThemeMode.

  @override
  String toString() => 'AppTheme(mode: $mode)';

  AppTheme copyWith({
    ThemeMode mode,
    ThemeData dark,
    ThemeData light,
    bool loading,
  }) {
    return AppTheme(
      mode: mode ?? this.mode,
      light: light ?? this.light,
      dark: dark ?? this.dark,
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return {'mode': mode?.index};
  }

  String toJson() => json.encode(toMap());
}
/*
AllTheme({
  Brightness brightness,
  VisualDensity visualDensity,
  MaterialColor primarySwatch,
  Color primaryColor,
  Brightness primaryColorBrightness,
  Color primaryColorLight,
  Color primaryColorDark,
  Color accentColor,
  Brightness accentColorBrightness,
  Color canvasColor,
  Color shadowColor,
  Color scaffoldBackgroundColor,
  Color bottomAppBarColor,
  Color cardColor,
  Color dividerColor,
  Color focusColor,
  Color hoverColor,
  Color highlightColor,
  Color splashColor,
  InteractiveInkFeatureFactory splashFactory,
  Color selectedRowColor,
  Color unselectedWidgetColor,
  Color disabledColor,
  Color buttonColor,
  ButtonThemeData buttonTheme,
  ToggleButtonsThemeData toggleButtonsTheme,
  Color secondaryHeaderColor,
  Color textSelectionColor,
  Color cursorColor,
  Color textSelectionHandleColor,
  Color backgroundColor,
  Color dialogBackgroundColor,
  Color indicatorColor,
  Color hintColor,
  Color errorColor,
  Color toggleableActiveColor,
  String fontFamily,
  TextTheme textTheme,
  TextTheme primaryTextTheme,
  TextTheme accentTextTheme,
  InputDecorationTheme inputDecorationTheme,
  IconThemeData iconTheme,
  IconThemeData primaryIconTheme,
  IconThemeData accentIconTheme,
  SliderThemeData sliderTheme,
  TabBarTheme tabBarTheme,
  TooltipThemeData tooltipTheme,
  CardTheme cardTheme,
  ChipThemeData chipTheme,
  TargetPlatform platform,
  MaterialTapTargetSize materialTapTargetSize,
  bool applyElevationOverlayColor,
  PageTransitionsTheme pageTransitionsTheme,
  AppBarTheme appBarTheme,
  BottomAppBarTheme bottomAppBarTheme,
  ColorScheme colorScheme,
  DialogTheme dialogTheme,
  FloatingActionButtonThemeData floatingActionButtonTheme,
  NavigationRailThemeData navigationRailTheme,
  Typography typography,
  CupertinoThemeData cupertinoOverrideTheme,
  SnackBarThemeData snackBarTheme,
  BottomSheetThemeData bottomSheetTheme,
  PopupMenuThemeData popupMenuTheme,
  MaterialBannerThemeData bannerTheme,
  DividerThemeData dividerTheme,
  ButtonBarThemeData buttonBarTheme,
  BottomNavigationBarThemeData bottomNavigationBarTheme,
  TimePickerThemeData timePickerTheme,
  TextButtonThemeData textButtonTheme,
  ElevatedButtonThemeData elevatedButtonTheme,
  OutlinedButtonThemeData outlinedButtonTheme,
  TextSelectionThemeData textSelectionTheme,
  DataTableThemeData dataTableTheme,
  bool fixTextFieldOutlineLabel,
  bool useTextSelectionTheme,
}) {}
 */
