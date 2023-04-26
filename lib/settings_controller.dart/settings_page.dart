// import 'package:flutter/material.dart';
// import 'package:gp/UI/widgets/appbar_widget.dart';
// import 'package:gp/core/Colors/colors.dart';
// import 'package:gp/core/Texts/app_text_styles.dart';
// import 'package:gp/core/app_theme.dart';
// import 'package:gp/settings_controller.dart/settingscontroller.dart';
// import 'package:provider/provider.dart';

// class SettingsPage extends StatefulWidget {
//   // final UserModel user;

//   const SettingsPage({
//     Key? key,
//     // required this.user,
//   }) : super(key: key);

//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     Size deviceSize = MediaQuery.of(context).size;

//     SettingsController controller = Provider.of<SettingsController>(context);

//     return Scaffold(
//       backgroundColor: controller.currentAppTheme.scaffoldBackgroundColor,
//       appBar: PreferredSize(
//         child: GradientAppBarWidget(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 20,
//                 ),
//                 // child: InkWell(
//                 //   // onTap: () {
//                 //   //       Navigator.popAndPushNamed(
//                 //   //         context,
//                 //   //        AppRoutes.homeRoute,
//                 //   //        arguments: HomePageArgs(user: widget.user),
//                 //   //       );
//                 //   // },
//                 //   child: Icon(
//                 //     Icons.arrow_back_ios,
//                 //     color: MyColors.white,
//                 //   ),
//                 // ),
//               ),
//               Text(
//                 "Configurações",
//                 style: AppTextStyles.titleBold.copyWith(
//                   color: MyColors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         preferredSize: Size.fromHeight(250),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: deviceSize.width * 0.1,
//           vertical: deviceSize.height * 0.05,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ValueListenableBuilder(
//               valueListenable: controller.themeNotifier,
//               builder: (ctx, value, _) => SettingsTile(
//                 title: "Tema escuro",
//                 switchValue: controller.currentAppTheme == AppTheme.darkTheme,
//                 onChanged: (v) {
//                   print("entrou aqui");
//                   Provider.of<SettingsController>(context, listen: false)
//                       .changeCurrentAppTheme();
//                   setState(() {});
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: deviceSize.width * 0.1,
//           vertical: deviceSize.height * 0.05,
//         ),
//       ),
//     );
//   }
// }

// class GradientAppBarWidget extends StatelessWidget {
//   final Widget child;
//   const GradientAppBarWidget({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 161,
//       width: double.maxFinite,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20,
//       ),
//       decoration: BoxDecoration(
//         gradient: AppGradients.linear,
//       ),
//       child: child,
//     );
//   }
// }

// class SettingsTile extends StatelessWidget {
//   final String title;
//   final bool switchValue;
//   final Function(bool) onChanged;
//   const SettingsTile({
//     Key? key,
//     required this.title,
//     required this.switchValue,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SettingsController settingsController =
//         Provider.of<SettingsController>(context);

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: AppTextStyles.heading.copyWith(
//             color: settingsController.currentAppTheme.primaryColor,
//           ),
//         ),
//         Switch(
//           value: switchValue,
//           onChanged: onChanged,
//           activeColor: Colors.purple,
//         ),
//       ],
//     );
//   }
// }
