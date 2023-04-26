// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/UI/Mom_UI/MomProfile.dart';
import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/UI/widgets/drawer.dart';
import 'package:gp/chat/sign_in_srceen.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:provider/provider.dart';

class StaffSettings extends StatefulWidget {
  @override
  State<StaffSettings> createState() => _StaffSettings();
}

class _StaffSettings extends State<StaffSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const StackContainer(),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CardItem(
                    label: "Name".tr(),
                    text: "Masa Masri",
                    edit: false,
                  ),
                  CardItem(
                    label: "Email".tr(),
                    text: "masa.masri@gmail.com",
                    idx: 2,
                    edit: false,
                  ),
                  CardItem(label: "Phone".tr(), text: "059484744", idx: 1),
                  // Card(
                  //     child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 16.0,
                  //           vertical: 21.0,
                  //         ),
                  //         child: tmp())),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        if (context.locale == Locale('ar')) {
                          context.setLocale(Locale('en'));
                          Provider.of<SettingsController>(context,
                                  listen: false)
                              .changeCurrentAppLanguage();
                        } else {
                          context.setLocale(Locale('ar'));
                          Provider.of<SettingsController>(context,
                                  listen: false)
                              .changeCurrentAppLanguage();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          context.locale == Locale('ar')
                              ? Text("ترجم إلى الانجليزية")
                              : Text("Switch to Arabic language"),
                          Icon(Icons.language),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.color3),
                    ),
                  ),

                  MomComand(
                    title: 'Log Out'.tr(),
                    subtitle: " ",
                    icon: Icon(Icons.logout),
                    color: MyColors.color4,
                    onPressed: (() {
                      AppRouter.appRouter.goToWidget(SignInPage1());
                    }),
                  )
                ],
              )),
        ],
      ),
    ));
  }
}

// class TopBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.menu, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CardItem extends StatelessWidget {
  String label;
  String text;
  bool edit;
  int idx;
  CardItem({
    Key? key,
    required this.label,
    required this.text,
    this.edit = true,
    this.idx = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 21.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            this.edit
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit your phone number'),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    TextField(
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    elevatedButon(
                                        text: 'Edit', onPressed: () {})
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30.0,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 150);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class StackContainer extends StatelessWidget {
  const StackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/8363040/pexels-photo-8363040.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 5, color: Colors.transparent)),
                    child: ClipOval(
                      child: Image.network(
                        "https://images.pexels.com/photos/5212317/pexels-photo-5212317.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  "Masa Masri",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Class ABC",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          // TopBar(),
        ],
      ),
    );
  }
}
