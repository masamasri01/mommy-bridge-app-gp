// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/MomProfile.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';

class StaffSettings extends StatefulWidget {
  @override
  State<StaffSettings> createState() => _StaffSettings();
}

class _StaffSettings extends State<StaffSettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherProvider>(builder: (context, prov, x) {
      var res = prov.teacherData;
      //print("res=" + res.toString());
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(name: res['name']),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    CardItem(
                      label: "Name".tr(),
                      text: res["name"],
                      edit: false,
                    ),
                    CardItem(
                      label: "Email".tr(),
                      text: res["email"],
                      idx: 2,
                      edit: false,
                    ),
                    CardItem(
                      label: "Phone".tr(),
                      text: res["phone"],
                      idx: 1,
                      onPressed: () {
                        Provider.of<TeacherProvider>(context, listen: false)
                            .updatePhone();
                        prov.setTeacherData();
                        Navigator.pop(context);
                      },
                    ),
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
    });
  }
}

class CardItem extends StatelessWidget {
  String label;
  String text;
  bool edit;
  int idx;
  VoidCallback? onPressed;

  CardItem({
    Key? key,
    required this.label,
    required this.text,
    this.edit = true,
    this.idx = 0,
    this.onPressed,
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
                                      controller: Provider.of<TeacherProvider>(
                                              context,
                                              listen: false)
                                          .phoneC,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    elevatedButon(
                                        text: 'Edit', onPressed: onPressed!)
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
  String name;

  StackContainer({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List image = Uint8List.fromList([0, 0].cast<int>());
    if (Provider.of<TeacherProvider>(context).teacherData['image'] != null) {
      List<dynamic> imageData =
          Provider.of<TeacherProvider>(context).teacherData['image']['data'];
      image = Uint8List.fromList(imageData.cast<int>());
    }
    //print(image.toString());
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
                    child: Stack(
                      children: [
                        // ClipOval(
                        //   child: (Provider.of<TeacherProvider>(context)
                        //               .teacherData['image'] ==
                        //           null)
                        //       ? Image.asset(
                        //           'lib/core/images/placeholder.png',
                        //           height: 200,
                        //           width: 200,
                        //           fit: BoxFit.cover,
                        //         )
                        //       : Image.memory(
                        //           image,
                        //           height: 200,
                        //           width: 200,
                        //           fit: BoxFit.cover,
                        //         ),
                        // ),
                        Positioned(
                          right: 5,
                          top: 80,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<TeacherProvider>(context,
                                          listen: false)
                                      .pickImageForTeacher(ImageSource.gallery);
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  name,
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
