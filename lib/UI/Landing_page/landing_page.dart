// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:gp/Providers/Teacher_provider.dart';
// import 'package:gp/Router/app_router.dart';
// import 'package:gp/UI/Mom_UI/mom_home_page.dart';
// import 'package:gp/UI/staff_functionalities/staff_home_page.dart/staff_home_page.dart';
// import 'package:gp/UI/staff_functionalities/staff_home_page.dart/staff_landing.dart';
// import 'package:gp/UI/widgets/custum_button.dart';
// import 'package:gp/core/app_theme.dart';
// import 'package:gp/settings_controller.dart/settingscontroller.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_localization/easy_localization.dart';

// class LandingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SettingsController controller = Provider.of<SettingsController>(context);

//     return Scaffold(
//       body: Column(children: [
//         Text("login".tr()),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             elevatedButon(
//                 text: "Teacher".tr(),
//                 onPressed: () {
//                   Provider.of<TeacherProvider>(context, listen: false).isMom =
//                       false;
//                   Provider.of<TeacherProvider>(context, listen: false)
//                       .isTeacher = true;
//                   AppRouter.appRouter.goToWidget(StaffLanding());
//                 }),
//             elevatedButon(
//                 text: "Mom".tr(),
//                 onPressed: () {
//                   Provider.of<TeacherProvider>(context, listen: false).isMom =
//                       true;
//                   Provider.of<TeacherProvider>(context, listen: false)
//                       .isTeacher = false;

//                   //  AppRouter.appRouter.goToWidget(MomHomePage());
//                 }),
//           ],
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 76),
//           child: ElevatedButton(
//               onPressed: () {
//                 if (context.locale == Locale('ar')) {
//                   context.setLocale(Locale('en'));
//                   Provider.of<SettingsController>(context, listen: false)
//                       .changeCurrentAppLanguage();
//                 } else {
//                   context.setLocale(Locale('ar'));
//                   Provider.of<SettingsController>(context, listen: false)
//                       .changeCurrentAppLanguage();
//                 }
//               },
//               child: Row(
//                 children: [
//                   context.locale == Locale('ar')
//                       ? Text("ترجم إلى الانجليزية")
//                       : Text("Switch to Arabic language"),
//                   Icon(Icons.language),
//                 ],
//               )),
//         )
//       ]),
//     );
//   }
// }
