import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/core/Texts/app_text_styles.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/core/app_theme.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
// Widget drawer() {
//   return Drawer(
//     backgroundColor: MyColors.color1,
//     child: Column(
//       children: [
//         Expanded(
//           child: ListView(
//             // Important: Remove any padding from the ListView.
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: MyColors.color2,
//                 ),
//                 child: Row(
//                   children: [
//                     ClipOval(
//                       child: CircleAvatar(
//                         radius: 27,
//                         backgroundColor: MyColors.color4,
//                         child: Image.network(
//                           "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX5614051.jpg",
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Masa Hassan",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                     )
//                   ],
//                 ),
//               ),
//               ListTile(
//                 title: const Text(
//                   'Item 1',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onTap: () {
//                   // Update the state of the app.
//                   // ...
//                 },
//               ),
//               ListTile(
//                 title: const Text(
//                   'Item 2',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onTap: () {
//                   // Update the state of the app.
//                   // ...
//                 },
//               ),
//               tmp(),
//               TextButton(
//                   onPressed: () {
//                     AppRouter.appRouter.goToWidgetAndReplace(LandingPage());
//                   },
//                   child: boldPinkText('Log Out'))
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

class tmp extends StatefulWidget {
  const tmp({super.key});

  @override
  State<tmp> createState() => _tmpState();
}

class _tmpState extends State<tmp> {
  @override
  Widget build(BuildContext context) {
    SettingsController controller = Provider.of<SettingsController>(context);
    return SettingsTile(
      title: "Arabic Language".tr(),
      switchValue: controller.currentAppLanguage == AppLanguage.arabic,
      onChanged: (v) {
        if (v) {
          Provider.of<SettingsController>(context, listen: false)
              .changeCurrentAppLanguage();
          context.setLocale(Locale('ar'));
        } else {
          Provider.of<SettingsController>(context, listen: false)
              .changeCurrentAppLanguage();
          context.setLocale(Locale('en'));
        }
      },
      current: controller.currentAppLanguage == AppLanguage.arabic
          ? "Arabic Language".tr()
          : "English Language".tr(),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String current;
  final bool switchValue;
  final Function(bool) onChanged;
  const SettingsTile({
    Key? key,
    required this.title,
    required this.current,
    required this.switchValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.heading15.copyWith(),
            ),
            Switch(
              value: switchValue,
              onChanged: onChanged,
              activeColor: MyColors.color2,
            ),
          ],
        ),
        Text("current language: ".tr() + current),
        ElevatedButton(
            onPressed: () {
              if (context.locale == Locale('ar')) {
                context.setLocale(Locale('en'));
                Provider.of<SettingsController>(context, listen: false)
                    .changeCurrentAppLanguage();
              } else {
                context.setLocale(Locale('ar'));
                Provider.of<SettingsController>(context, listen: false)
                    .changeCurrentAppLanguage();
              }
            },
            child: Icon(Icons.language))
      ],
    );
  }
}
