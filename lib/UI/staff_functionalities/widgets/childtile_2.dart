// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/time_picker.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ChildTile2 extends StatelessWidget {
  String? name;
  List image;
  int index;
  bool activities;
  bool? attendance;
  ChildTile2(
      {required this.index,
      required this.name,
      required this.image,
      this.activities = false,
      this.attendance = false});

  @override
  Widget build(BuildContext context) {
    Uint8List image1 = Uint8List.fromList([0, 0].cast<int>());
    List<dynamic> imageData = image;
    image1 = Uint8List.fromList(imageData.cast<int>());

    TextEditingController enteryTimeController =
        Provider.of<TeacherProvider>(context, listen: false)
            .enteryTimeController;
    TextEditingController pickUpTimeController =
        Provider.of<TeacherProvider>(context, listen: false)
            .pickUpTimeController;
    return Row(
      children: [
        Container(
            padding: EdgeInsets.only(top: 12, bottom: 9, left: 16, right: 17),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(
                    color: (getcolor()), width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
                //   boxShadow: const [
                //     BoxShadow(
                //       color: Color(0x0a2c2738),
                //       offset: Offset(0, 4),
                //       blurRadius: 8,
                //     ),
                //   ],
                color: Color.fromARGB(156, 255, 255, 255)),
            child: Column(children: [
              SizedBox(
                width: 0.7 * MediaQuery.of(context).size.width,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    activities == true
                        ? ClipOval(
                            child: CircleAvatar(
                                child: Container(
                              decoration: BoxDecoration(color: Colors.white12),
                            )
                                //  Image.asset(
                                //   image1,
                                //   width: 100,
                                //   height: 100,
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                          )
                        : ClipOval(
                            child: CircleAvatar(
                              child: Image.memory(
                                image1,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      name ?? " ",
                      style: TextStyle(
                          color: getcolor(),
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              this.attendance == false
                  ? Container()
                  : Column(
                      children: [
                        MyTimePicker(
                          text: 'Entery Time'.tr(),
                          timeController: enteryTimeController,
                        ),
                        MyTimePicker(
                          text: 'Pick Up time'.tr(),
                          timeController: pickUpTimeController,
                        )
                      ],
                    ),
            ]))
      ],
    );
  }

  getcolor() {
    int numm = (index + 1) % 2;
    if (numm == 0)
      return MyColors.color1;
    else if (numm == 1) return MyColors.color3;
  }
}
