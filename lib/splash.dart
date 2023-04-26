import 'package:flutter/material.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/UI/widgets/appbar_widget.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  void setTheme(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("language")) {
      String? savedTheme = prefs.getString("language");
      print("saved theme: $savedTheme");
      Provider.of<SettingsController>(context, listen: false)
          .changeCurrentAppLanguage(lan: savedTheme);
    }
  }

  @override
  Widget build(BuildContext context) {
    setTheme(context);

    Future.delayed(Duration(seconds: 2)).then(
      (value) => AppRouter.appRouter.goToWidgetAndReplace(LandingPage()),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(child: Icon(Icons.abc)),
      ),
    );
  }
}
