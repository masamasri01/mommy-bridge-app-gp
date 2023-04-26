// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/UI/widgets/text_area.dart';

import 'package:gp/core/API/children.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class childProfileForMom extends StatelessWidget {
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
                    label: "Class".tr(),
                    text: "ABC",
                    ss: "",
                  ),
                  CardItem(
                      label: "Birth Of Date".tr(),
                      text: "16/7/2019",
                      edit: true,
                      ss: "date"),
                  CardItem(
                      label: "Address".tr(),
                      text: "Rafidia Street",
                      edit: true,
                      ss: "address"),
                  CardItem(
                    label: "Hobbies & Preferences".tr(),
                    text: "masa.masri@gmail.com",
                    islist: true,
                    list: ["Pasta", "football", "Hide & Seek"],
                    edit: true,
                    add: true,
                    ss: "hobby",
                  ),
                  CardItem(
                    label: "Food Allergies from".tr(),
                    text: "059484744",
                    islist: true,
                    list: ["Eggs", "milk"],
                    ss: "allergy",
                    edit: true,
                    add: true,
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

List<String> s = [];

class CardItem extends StatelessWidget {
  String label;
  String text;
  bool islist;
  bool edit;
  String ss;
  bool add;
  List<String> list;
  CardItem(
      {Key? key,
      required this.label,
      required this.text,
      required this.ss,
      this.islist = false,
      this.edit = false,
      this.add = false,
      this.list = const ["x"]})
      : super(key: key);

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
                islist
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: list
                            .map((e) => RichText(
                                    text: TextSpan(
                                        text: ' ● ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.color1,
                                            fontSize: 16),
                                        children: <TextSpan>[
                                      TextSpan(text: e),
                                    ])))
                            .toList())
                    : Text(
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
                      if (ss == "date")
                        date(context);
                      else if (ss == "address")
                        address(context);
                      else if (ss == "allergy")
                        allergy(context);
                      else if (ss == "hobby") hobby(context);
                    },
                    icon: Icon(
                      add ? Icons.add : Icons.edit,
                      size: 30.0,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  date(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit Birth of Date').tr(),
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
                  elevatedButon(text: 'Edit'.tr(), onPressed: () {})
                ],
              ),
            ),
          );
        });
  }

  address(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit address').tr(),
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
                  elevatedButon(text: 'Edit'.tr(), onPressed: () {})
                ],
              ),
            ),
          );
        });
  }

  allergy(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add allergy').tr(),
              content: SizedBox(
                height: 180,
                width: 300,
                child: Column(children: [
                  MyTextField(
                      label: 'Allergy'.tr(),
                      hint: 'add allergy'.tr(),
                      controller:
                          Provider.of<MomProvider>(context, listen: false)
                              .allergyNameController),
                  Divider(),
                  elevatedButon(text: 'Add'.tr(), onPressed: () {}),
                  Divider(),
                ]),
              ));
        });
  }

  hobby(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Add Hobby').tr(),
              content: SizedBox(
                height: 200,
                width: 300,
                child: Column(children: [
                  MyTextField(
                      label: 'Hobbies and Preferences'.tr(),
                      hint: 'enter here'.tr(),
                      controller:
                          Provider.of<MomProvider>(context, listen: false)
                              .preferenceNameController),
                  Divider(),
                  elevatedButon(text: 'Add'.tr(), onPressed: () {}),
                  Divider(),
                ]),
              ));
        });
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
                      "https://images.pexels.com/photos/1364073/pexels-photo-1364073.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
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
                    child: Stack(children: [
                      ClipOval(
                          child: Center(
                        child: (Provider.of<TeacherProvider>(context)
                                    .childImageFile ==
                                null)
                            ? Image.asset(
                                'lib/core/images/placeholder.png',
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                Provider.of<TeacherProvider>(context)
                                    .childImageFile!,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                      ))

                      //  Image.network(
                      //   childrenList[2]["image"],
                      //   height: 200,
                      //   width: 200,
                      //   fit: BoxFit.cover,
                      // ),
                      ,
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
                                    .pickImageForChild(ImageSource.gallery);
                              },
                              icon: Icon(Icons.edit)),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 4.0),
                const Text(
                  "Eleen Masri",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "child".tr(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
