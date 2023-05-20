import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
//import 'package:gp/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/childtile_2.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class Naps extends StatefulWidget {
  final token;
  const Naps({super.key, required this.token});

  @override
  State<Naps> createState() => _NapsState();
}

class _NapsState extends State<Naps> {
  final timeController = TextEditingController();
  final timeController2 = TextEditingController();
  // String childId;
  var _value;
  List mychildrenList = [];
  String? userId;
  // @override
  // void initState() {
  //   super.initState();
  //   Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

  //   userId = jwtDecodedToken['_id'];
  //   print("id-----------------" + userId);
  //   getMyClassChildrenList(userId);
  // }

  void addNap(childId) async {
    if (timeController.text.isNotEmpty && timeController2.text.isNotEmpty) {
      var regBody = {
        "startTime": timeController.text,
        "endTime": timeController2.text,
        "childId": childId
      };

      var response = await http.post(Uri.parse(napAdd),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        timeController.clear();
        timeController2.clear();
        Navigator.pop(context);
        // setState(() {
        //   getTodoList(userId);
        // });
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  void getMyClassChildrenList(userId) async {
    var regBody = {"teacherId": userId};

    var response = await http.post(Uri.parse(MyChildrenListGet),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    print('response json ' + jsonResponse.toString());

    setState(() {
      mychildrenList = jsonResponse['success'];

      print(jsonResponse['success'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    mychildrenList = Provider.of<TeacherProvider>(context).myChildrenList;
    userId = Provider.of<TeacherProvider>(context).teacherId;
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
              itemCount: mychildrenList.length,
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
                      name: mychildrenList[index]['fullName'],
                      image: mychildrenList[index]['image']),
                ]);
              },
            ),
          ),
          Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    addNap(mychildrenList[_value]['_id']);
                  },
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
