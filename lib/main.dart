import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gp/Homeworks/shapes_quiz/shapes_speech_app.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gp/Providers/App_provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/Router/app_router.dart';

import 'package:gp/UI/introduction_screen.dart';

import 'package:gp/core/Colors/color_codes.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/firebase_options.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:gp/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: const [Locale('en'), Locale('ar')],
      path:
          'assets/translations', // <-- change the path of the translation files
      // fallbackLocale: Locale('en'),
      child: MyApp(
        token: prefs.getString('token'),
      )));
}

class MyApp extends StatelessWidget {
  final token;

  const MyApp({super.key, required this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<TeacherProvider>(
        create: (context) {
          return TeacherProvider();
        },
      ),
      ChangeNotifierProvider<SettingsController>(
        create: (context) {
          return SettingsController();
        },
      ),
      ChangeNotifierProvider<MomProvider>(
        create: (context) {
          return MomProvider();
        },
      ),
      ChangeNotifierProvider<QuizProvider>(
        create: (context) {
          return QuizProvider();
        },
      ),
      ChangeNotifierProvider<AppProvider>(
        create: (context) {
          return AppProvider();
        },
      ),
    ], child: cc());
  }
}

class cc extends StatelessWidget {
  const cc({super.key});

  @override
  Widget build(BuildContext context) {
    // context.setLocale(Provider.of<SettingsController>(context, listen: false)
    //     .currentAppLanguage);
    //print('token in cc is' + token);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      //  Provider.of<SettingsController>(context, listen: false)
      //             .currentAppLanguage ==
      //         AppLanguage.arabic
      //     ? Locale('ar')
      //     : Locale('en'),

      navigatorKey: AppRouter.appRouter.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        //  primarySwatch: blueSwatch,
        primarySwatch: Colors.pink,
        primaryColor: Color.fromRGBO(154, 167, 255, .7),
        timePickerTheme: TimePickerThemeData(),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: MyColors.color1),
        // scaffoldBackgroundColor: Provider.of<SettingsController>(context)
        //     .currentAppTheme
        //     .scaffoldBackgroundColor,
        textTheme: GoogleFonts.openSansTextTheme(
          TextTheme(
            button: TextStyle(color: Colors.white),
          ),
        ),
        //         bodyColor: Colors.white,
        //         displayColor: Colors.white,
        //         decorationColor: Colors.white))
        //     : GoogleFonts.openSansTextTheme(Theme.of(context).textTheme.apply(
        //           bodyColor: Colors.black,
        //           displayColor: Colors.black,
        //         ))
      ),
      home: SignInPage1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
