// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/MomProfile.dart';
import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/UI/widgets/text_area.dart';
import 'package:gp/core/Colors/colors.dart';

class childProfileForMom extends StatefulWidget {
  String childId;
  bool forMom = true;
  childProfileForMom({Key? key, required this.childId, this.forMom = true})
      : super(key: key);

  @override
  State<childProfileForMom> createState() => _childProfileForMomState();
}

class _childProfileForMomState extends State<childProfileForMom> {
  var res;
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    (widget.forMom == true)
        ? await Provider.of<MomProvider>(context, listen: false)
            .getMyChildData(widget.childId)
        : await Provider.of<TeacherProvider>(context, listen: false)
            .getMyChildData(widget.childId);
    (widget.forMom == true)
        ? res = Provider.of<MomProvider>(context, listen: false).childData
        : res = Provider.of<TeacherProvider>(context, listen: false).childData;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.forMom == true)
        ? Consumer<MomProvider>(builder: (context, prov, x) {
            Provider.of<MomProvider>(context, listen: false)
                .getMyChildData(widget.childId);
            Uint8List image1 = Uint8List.fromList([0, 0].cast<int>());

            List<dynamic> imageData =
                Provider.of<MomProvider>(context).childData['image']['data'];
            image1 = Uint8List.fromList(imageData.cast<int>());

            return Scaffold(
                body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StackContainer(
                    name: prov.childData["fullName"],
                    childId: prov.childData["_id"],
                    image: image1,
                    editImage: true,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          CardItem(
                            label: "Class".tr(),
                            text: prov.childData["classId"]["className"] ??
                                "not entered",
                            ss: "",
                          ),
                          CardItem(
                              label: "Birth Of Date".tr(),
                              text:
                                  prov.childData["birthDate"] ?? "not entered",
                              edit: false,
                              ss: "date"),
                          CardItem(
                            label: "Address".tr(),
                            text: prov.childData["address"] ?? "not entered",
                            edit: true,
                            ss: "address",
                            childId: widget.childId,
                          ),
                          CardItem(
                            label: "Hobbies & Preferences".tr(),
                            text: "masa.masri@gmail.com",
                            islist: true,
                            list: prov.childData["hobbies"] ?? [],
                            edit: true,
                            add: true,
                            ss: "hobby",
                            childId: widget.childId,
                          ),
                          CardItem(
                            label: "Food Allergies from".tr(),
                            text: "059484744",
                            islist: true,
                            list: prov.childData["allergies"] ?? [],
                            ss: "allergy",
                            edit: true,
                            add: true,
                            childId: widget.childId,
                          ),
                        ],
                      )),
                ],
              ),
            ));
          })
        : Consumer<TeacherProvider>(builder: (context, prov, x) {
            // Provider.of<TeacherProvider>(context, listen: false)
            //     .getMyChildData(widget.childId);
            Uint8List image1 = Uint8List.fromList([0, 0].cast<int>());

            List<dynamic> imageData = Provider.of<TeacherProvider>(context)
                .childData['image']['data'];
            image1 = Uint8List.fromList(imageData.cast<int>());

            return Scaffold(
                body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StackContainer(
                    name: prov.childData["fullName"],
                    childId: prov.childData["_id"],
                    image: image1,
                    editImage: false,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          MomComand(
                            title: 'Mom Details'.tr(),
                            subtitle: "click to see mom's details".tr(),
                            icon: Icon(Icons.medication_outlined),
                            color: MyColors.color4,
                            onPressed: (() async {
                              await Provider.of<TeacherProvider>(context,
                                      listen: false)
                                  .getMomDataByChildId(widget.childId);
                              print(Provider.of<TeacherProvider>(context,
                                      listen: false)
                                  .getMomDataByChildId(widget.childId)
                                  .toString());
                              AppRouter.appRouter.goToWidget(MomProfile(
                                  forTeacher: true, childId: widget.childId));
                            }),
                          ),
                          CardItem(
                            label: "Mom".tr(),
                            text: prov.childData["classId"]["className"] ??
                                "not entered",
                            ss: "",
                          ),
                          CardItem(
                            label: "Class".tr(),
                            text: prov.childData["classId"]["className"] ??
                                "not entered",
                            ss: "",
                          ),
                          CardItem(
                              label: "Birth Of Date".tr(),
                              text:
                                  prov.childData["birthDate"] ?? "not entered",
                              edit: false,
                              ss: "date"),
                          CardItem(
                            label: "Address".tr(),
                            text: prov.childData["address"] ?? "not entered",
                            edit: false,
                            ss: "address",
                            childId: prov.childData["_id"],
                          ),
                          CardItem(
                            label: "Hobbies & Preferences".tr(),
                            text: "masa.masri@gmail.com",
                            islist: true,
                            list: prov.childData["hobbies"] ?? [],
                            edit: false,
                            add: true,
                            ss: "hobby",
                            childId: prov.childData["_id"],
                          ),
                          CardItem(
                            label: "Food Allergies from".tr(),
                            text: "059484744",
                            islist: true,
                            list: prov.childData["allergies"] ?? [],
                            ss: "allergy",
                            edit: false,
                            add: true,
                            childId: prov.childData["_id"],
                          ),
                        ],
                      )),
                ],
              ),
            ));
          });
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

//List<String> s = [];

class CardItem extends StatelessWidget {
  String label;
  String text;
  bool islist;
  bool edit;
  String ss;
  bool add;
  List list;
  String? childId;
  CardItem(
      {Key? key,
      required this.label,
      required this.text,
      required this.ss,
      this.islist = false,
      this.edit = false,
      this.add = false,
      this.childId,
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
                      else if (ss == "address") {
                        address(context);
                      } else if (ss == "allergy") {
                        allergy(context);
                      } else if (ss == "hobby") hobby(context);
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
                    controller: Provider.of<MomProvider>(context, listen: false)
                        .addressC,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  elevatedButon(
                      text: 'Edit'.tr(),
                      onPressed: () {
                        Provider.of<MomProvider>(context, listen: false)
                            .updateChildAddresss();
                        Navigator.pop(context);
                      })
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
                  elevatedButon(
                      text: 'Add'.tr(),
                      onPressed: () {
                        // print("adding allergy, allergy controller text:" +
                        //     Provider.of<MomProvider>(context, listen: false)
                        //         .allergyNameController
                        //         .text +
                        //     "child id = " +
                        //     childId!);
                        Provider.of<MomProvider>(context, listen: false)
                            .addAllergy(
                                childId!,
                                Provider.of<MomProvider>(context, listen: false)
                                    .allergyNameController
                                    .text);
                        Provider.of<MomProvider>(context, listen: false)
                            .allergyNameController
                            .clear();
                        Provider.of<MomProvider>(context, listen: false)
                            .getMyChildData(childId!);
                        Navigator.pop(context);
                      }),
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
                  elevatedButon(
                      text: 'Add'.tr(),
                      onPressed: () {
                        // print("adding hobby, allergy controller text:" +
                        //     Provider.of<MomProvider>(context, listen: false)
                        //         .preferenceNameController
                        //         .text +
                        //     "child id = " +
                        //     childId!);
                        Provider.of<MomProvider>(context, listen: false)
                            .addHobby(
                                childId!,
                                Provider.of<MomProvider>(context, listen: false)
                                    .preferenceNameController
                                    .text);
                        Provider.of<MomProvider>(context, listen: false)
                            .preferenceNameController
                            .clear();
                        Provider.of<MomProvider>(context, listen: false)
                            .getMyChildData(childId!);
                        Navigator.pop(context);
                      }),
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
  String name;
  String childId;
  bool editImage;
  Uint8List? image;
  StackContainer({
    Key? key,
    required this.name,
    required this.childId,
    required this.editImage,
    required this.image,
  }) : super(key: key);

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
                        child:
                            (image == Uint8List.fromList([0, 0].cast<int>()) ||
                                    image == null)
                                ? Image.asset(
                                    'lib/core/images/placeholder.png',
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    image!,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                      )),
                      (editImage == true)
                          ? Positioned(
                              right: 5,
                              top: 80,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      Provider.of<TeacherProvider>(context,
                                              listen: false)
                                          .pickImageForChild(
                                              ImageSource.gallery, childId);
                                    },
                                    icon: Icon(Icons.edit)),
                              ),
                            )
                          : SizedBox()
                    ]),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  this.name,
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
