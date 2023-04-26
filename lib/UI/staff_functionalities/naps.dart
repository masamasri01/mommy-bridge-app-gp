import 'package:flutter/material.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
//import 'package:gp/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/childtile_2.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';

class Naps extends StatefulWidget {
  const Naps({super.key});

  @override
  State<Naps> createState() => _NapsState();
}

class _NapsState extends State<Naps> {
  final timeController = TextEditingController();
  final timeController2 = TextEditingController();
  var _value;
  @override
  Widget build(BuildContext context) {
    String value = "";

    String value2 = "";
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ab('Naps'.tr()),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          boldText('Nap started at:'.tr()),

          ///******************************************** */
          Container(
            //  width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffdbe2ea)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0a2c2738),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: TextField(
              controller: timeController,
              readOnly: true,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    var time = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xffE5E0A1),
                              onPrimary: Colors.black,
                              surface: Colors.white,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    print(time!.format(context));
                    timeController.text = time.format(context);
                    // scheduleAlarm();
                  },
                  icon: const Icon(
                    Icons.add_alert,
                    color: Colors.deepPurple,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                border: InputBorder.none,
                hintText: "Add Start time".tr(),
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Color(0xffcbd0d6),
                ),
              ),
              onChanged: (text) {
                value = text;
                print(value);
              },
            ),
          ),

          ///******************************************** */
          boldText('Nap Ended at:'.tr()),
          Container(
            //  width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffdbe2ea)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0a2c2738),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: TextField(
              controller: timeController2,
              readOnly: true,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    var time = await showTimePicker(
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xffE5E0A1),
                              onPrimary: Colors.black,
                              surface: Colors.white,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    // print(time!.format(context));
                    timeController2.text = time!.format(context);
                    // scheduleAlarm();
                  },
                  icon: const Icon(
                    Icons.add_alert,
                    color: Colors.deepPurple,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                border: InputBorder.none,
                hintText: "Add End time".tr(),
                hintStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  color: Color(0xffcbd0d6),
                ),
              ),
              onChanged: (text) {
                value2 = text;
                //  print(value2);
              },
            ),
          ),
          // boldText('Choose Child:'),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: childrenList.length,
              itemBuilder: (context, index) {
                return Row(children: [
                  Radio(
                    value: index,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                  ),
                  ChildTile2(
                      index: index,
                      name: childrenList[index]['name'],
                      image: childrenList[index]['image']),
                ]);
              },
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Post'.tr()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.color1),
                ),
              )),
        ],
      ),
    );
  }
}
