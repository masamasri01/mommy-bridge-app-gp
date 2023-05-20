// import 'package:gp/Providers/Teacher_provider.dart';
// import 'package:gp/Router/app_router.dart';
// import 'package:gp/UI/Mom_UI/mom_home_page.dart';
// import 'package:gp/UI/staff_functionalities/staff_home_page.dart/staff_landing.dart';
// import 'package:gp/UI/widgets/custum_button.dart';
// import 'package:gp/chat/chatpage.dart';
// import 'package:gp/chat/chat_home_page.dart';
// import 'package:flutter/material.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:gp/core/Colors/colors.dart';
// import 'package:gp/settings_controller.dart/settingscontroller.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_localization/easy_localization.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   // Define text editing controllers for email and password fields
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Sign In'),
//       // ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Sign In'.tr(),
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               // Email field
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                 ),
//               ),
//               SizedBox(height: 12.0),

//               // Password field
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 12.0),

//               // Sign In button
//               // ElevatedButton(
//               //   onPressed: () {
//               //     // Call sign in method
//               //     _signInWithEmailAndPassword();
//               //   },
//               //   child: Text('Mom'),
//               // ),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     // Call sign in method
//               //     _signInWithEmailAndPassword();
//               //   },
//               //   child: Text('Teacher'),
//               // ),
//               Text("login".tr()),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   elevatedButon(
//                       text: "Teacher".tr(),
//                       onPressed: () {
//                         Provider.of<TeacherProvider>(context, listen: false)
//                             .isMom = false;
//                         Provider.of<TeacherProvider>(context, listen: false)
//                             .isTeacher = true;
//                         // AppRouter.appRouter.goToWidget(StaffLanding());
//                         _signInWithEmailAndPassword(2);
//                       }),
//                   elevatedButon(
//                       text: "Mom".tr(),
//                       onPressed: () {
//                         Provider.of<TeacherProvider>(context, listen: false)
//                             .isMom = true;
//                         Provider.of<TeacherProvider>(context, listen: false)
//                             .isTeacher = false;
//                         //    _signInWithEmailAndPassword(MomHomePage());
//                         //  AppRouter.appRouter.goToWidget(MomHomePage());
//                       }),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 5),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (context.locale == Locale('ar')) {
//                       context.setLocale(Locale('en'));
//                       Provider.of<SettingsController>(context, listen: false)
//                           .changeCurrentAppLanguage();
//                     } else {
//                       context.setLocale(Locale('ar'));
//                       Provider.of<SettingsController>(context, listen: false)
//                           .changeCurrentAppLanguage();
//                     }
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       context.locale == Locale('ar')
//                           ? Text("ترجم إلى الانجليزية")
//                           : Text("Switch to Arabic language"),
//                       Icon(Icons.language),
//                     ],
//                   ),
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: MyColors.color3),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Sign in with email and password using Firebase Authentication
//   void _signInWithEmailAndPassword(Widget w) async {
//     try {
//       // Call Firebase Authentication sign in method
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );

//       // Navigate to home screen on successful sign in

//       AppRouter.appRouter.goToWidgetAndReplace(w);
//     } on FirebaseAuthException catch (e) {
//       // Display error message on failed sign in
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
// }
