import 'package:flutter/material.dart';
import 'package:gp/core/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

//arabic=dark
class SettingsController extends ChangeNotifier {
  // ValueNotifier<ThemeData> themeNotifier =
  //     ValueNotifier<ThemeData>(AppTheme.lightTheme);

  // ThemeData get currentAppTheme => themeNotifier.value;
  // set currentAppTheme(ThemeData value) => themeNotifier.value = value;

  // void changeCurrentAppTheme({String? theme}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   if (theme != null) {
  //     if (theme.toLowerCase() == "dark") {
  //       _setDarkTheme(prefs);
  //     } else {
  //       _setLightTheme(prefs);
  //     }
  //   } else {
  //     if (currentAppTheme == AppTheme.lightTheme) {
  //       _setDarkTheme(prefs);
  //     } else if (currentAppTheme == AppTheme.darkTheme) {
  //       _setLightTheme(prefs);
  //     }
  //   }
  //   notifyListeners();
  // }

  // void _setDarkTheme(SharedPreferences prefs) {
  //   currentAppTheme = AppTheme.darkTheme;
  //   prefs.setString("theme", "dark");
  // }

  // void _setLightTheme(SharedPreferences prefs) {
  //   currentAppTheme = AppTheme.lightTheme;
  //   prefs.setString("theme", "light");
  // }
  /*********************8 */
  //
  ValueNotifier<Locale> languageNotifier =
      ValueNotifier<Locale>(AppLanguage.english);
  Locale get currentAppLanguage => languageNotifier.value;
  set currentAppLanguage(Locale value) => languageNotifier.value = value;

  void changeCurrentAppLanguage({String? lan}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (lan != null) {
      if (lan.toLowerCase() == "arabic") {
        _setArabicLanguage(prefs);
      } else {
        _setEnglishLanguage(prefs);
      }
    } else {
      if (currentAppLanguage == AppLanguage.english) {
        _setArabicLanguage(prefs);
      } else if (currentAppLanguage == AppLanguage.arabic) {
        _setEnglishLanguage(prefs);
      }
    }
    notifyListeners();
  }

  void _setArabicLanguage(SharedPreferences prefs) {
    currentAppLanguage = AppLanguage.arabic;
    prefs.setString("language", "arabic");
  }

  void _setEnglishLanguage(SharedPreferences prefs) {
    currentAppLanguage = AppLanguage.english;
    prefs.setString("language", "english");
  }

//
}
