import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dmg_io_mobile/src/models/index.dart';
import 'package:dmg_io_mobile/src/utils/index.dart';
import 'package:dmg_io_mobile/src/repositories/app_theme.dart';

final themeProvider = StateNotifierProvider<ThemeCtrl>((ref) => ThemeCtrl(ref: ref));

class ThemeCtrl extends StateNotifier<AppTheme> {
  ThemeCtrl({this.ref, ThemeMode mode})
      : super(AppTheme(
          mode: mode ?? ThemeMode.values[ThemeMode.system.index],
          light: lightTheme,
          dark: darkTheme,
          loading: false,
        ));

  final ProviderReference ref;

  init(int themeIndex) async {
    final mode = ThemeMode.values[themeIndex ?? ThemeMode.system.index];
    state = state.copyWith(
      mode: mode,
      light: lightTheme,
      dark: darkTheme,
      loading: false,
    );
    ref.read(themeRepoProvider).saveMode(mode);
  }

  setTheme(String key) async {
    ThemeMode mode = enumFrom(ThemeMode.values, key);
    state = state.copyWith(mode: mode);
    ref.read(themeRepoProvider).saveMode(mode);
  }
}

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  //primaryColor: Color(0xFF1C1C1C),
  scaffoldBackgroundColor: Color(0xFF1A1A1A),
  //primarySwatch: Colors.white,
  //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
  appBarTheme: AppBarTheme(color: Color(0xFF292725)),
  accentColor: Color(0xC9A06627),
  dividerTheme: DividerThemeData(
    color: Colors.white38,
    thickness: 1,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    color: Color(0xFF302F2F),
    shadowColor: Color(0xFFA5A5A5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  ),
  iconTheme: IconThemeData(color: Colors.white, size: 28, opacity: 1.0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAF8D6B)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
        fontSize: 15.0,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      )),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.white, width: 5),
        ),
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF6E1E79),
    disabledColor: Colors.white38,
    focusColor: Colors.white.withOpacity(0.12),
    hoverColor: Colors.white.withOpacity(0.04),
    highlightColor: Color(0x40CCCCCC),
    splashColor: Color(0x40CCCCCC),
    materialTapTargetSize: MaterialTapTargetSize.padded,
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFFFFFFFFC),
  accentColor: Color(0xFF330E38),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white, size: 50),
  ),
  iconTheme: IconThemeData(color: Colors.white, size: 50),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    buttonColor: Color(0xFF6E1E79),
    disabledColor: Colors.black38,
    focusColor: Colors.black.withOpacity(0.12),
    hoverColor: Colors.black.withOpacity(0.04),
    highlightColor: Color(0xB4BCBCBC),
    splashColor: Color(0x66C8C8C8),
    materialTapTargetSize: MaterialTapTargetSize.padded,
  ),
);
