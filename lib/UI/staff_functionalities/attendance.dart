import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/date_widget.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/attend_child.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  late TextEditingController enteryTimeController;
  late TextEditingController pickUpTimeController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    enteryTimeController = Provider.of<TeacherProvider>(context, listen: false)
        .enteryTimeController;
    pickUpTimeController = Provider.of<TeacherProvider>(context, listen: false)
        .pickUpTimeController;
  }

  bool checked = false;
  late List attendList;

  late List myClassChildrenList;

  void addAttendance() async {
    for (int i = 0; i < myClassChildrenList.length; i++) {
      var regBody = {
        "attend": attendList[i],
        "enteryTime": enteryTimeController.text,
        "pickUpTime": pickUpTimeController.text,
        "childId": myClassChildrenList[i]["_id"]
      };

      var response = await http.post(Uri.parse(attendAdd),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
      } else {
        print("SomeThing Went Wrong");
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    myClassChildrenList = Provider.of<TeacherProvider>(context).myChildrenList;
    // userId = Provider.of<TeacherProvider>(context, listen: false).userId;

    attendList = Provider.of<AppProvider>(context).attendance;
    return Scaffold(
      appBar: ab('Enter Attendance Details'.tr()),
      body: Column(
        children: [
          ShowDate(),
          navyText('Record absent children'.tr()),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myClassChildrenList.length,
              itemBuilder: (context, index) {
                return AttendanceChildtile(
                    index: index,
                    attendance: true,
                    name: myClassChildrenList[index]['fullName'],
                    image: myClassChildrenList[index]['image']);
              },
            ),
          ),
          Divider(
            color: MyColors.color1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //  elevatedButon(text: 'assign all as attendant', onPressed: () {}),
              const SizedBox(
                width: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    addAttendance();
                  },
                  child: boldText2('  Post  '.tr()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.color1),
                ),
              )
            ],
          )
        ],
      ),

      // CustomCheckBox(
      //   value: checked,
      //   onChanged: (value) {
      //     setState(() {
      //       checked = value;
      //     });
      //   },
      // ),
    );
  }
}
