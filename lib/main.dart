import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gp/Homeworks/Seasons/drag_drop.dart';
import 'package:gp/Homeworks/color_quiz/speech_to_text.dart';
import 'package:gp/Homeworks/tracing/drawing.dart';
import 'package:gp/Notifications/notification.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/UI/Mom_UI/mom_home_page.dart';
import 'package:gp/UI/introduction_screen.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph_leader.dart';
import 'package:gp/UI/staff_functionalities/staff_home_page.dart/staff_landing.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/chat/chat_home_page.dart';
import 'package:gp/chat/sign_in_srceen.dart';
import 'package:gp/core/Colors/color_codes.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/app_theme.dart';
import 'package:gp/firebase_options.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:gp/practice%20db/registeration.dart';

import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:gp/splash.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    ], child: cc());
  }
}

class cc extends StatelessWidget {
  const cc({super.key});

  @override
  Widget build(BuildContext context) {
    // context.setLocale(Provider.of<SettingsController>(context, listen: false)
    //     .currentAppLanguage);
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
        primarySwatch: blueSwatch,

        primaryColor: Color.fromRGBO(254, 113, 101, 1),
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
      home:
          //SpeechSampleApp()
          IntroScreen(),
      //  StaffLanding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
