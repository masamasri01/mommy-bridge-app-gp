import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class AppTheme {
  static Color backgroundColors(Brightness brightness) =>
      brightness == Brightness.light ? MyColors.white : Color(0xFF333333);
  static Color TextColors(Brightness brightness) =>
      brightness == Brightness.dark ? MyColors.white : Color(0xFF333333);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(253, 255, 255, 255),
    primaryColor: Colors.black,
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    // textTheme:
    //     TextTheme(bodyText1: TextStyle(color: Color.fromARGB(239, 0, 0, 0)))
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(107, 200, 200, 200),
    primaryColor: MyColors.color3,
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Color.fromARGB(121, 158, 158, 158)),
    dividerColor: Colors.black12,
    // textTheme: TextTheme(
    //   bodyText1: TextStyle(
    //     color: Colors.white,
    //   ),
    //   displayMedium: TextStyle(
    //     color: Colors.white,
    //   ),
    // )
  );
}

class AppLanguage {
  static final Locale arabic = Locale('ar');
  static final Locale english = Locale('en');
}
