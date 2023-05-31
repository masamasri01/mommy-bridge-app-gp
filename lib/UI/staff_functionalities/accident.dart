import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/attend_child.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/text_area.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Accident extends StatefulWidget {
  @override
  State<Accident> createState() => _AccidentState();
}

class _AccidentState extends State<Accident> {
  String dropdownvalue = 'Fall';

// List of items in our dropdown menu
  var items = [
    'Burn',
    'Fall',
    'Trip',
    'Other',
  ];
  List myClassChilrenList = [];
  late List attendList;
  TextEditingController accidentController = TextEditingController();
  void addAccident() async {
    print("-----------------");

    for (int i = 0; i < myClassChilrenList.length; i++) {
      if (attendList[i] == true) {
        print("-----------------" + myClassChilrenList[i]['_id']);
        var regBody = {
          "accidentType": dropdownvalue,
          "description": accidentController.text ?? "",
          "childId": myClassChilrenList[i]['_id']
        };

        var response = await http.post(Uri.parse(accidentAdd),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse['status']);

        if (jsonResponse['status']) {
        } else {
          print("SomeThing Went Wrong");
        }
      }
    }
    accidentController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    myClassChilrenList =
        Provider.of<TeacherProvider>(context, listen: false).myChildrenList;
    attendList = Provider.of<AppProvider>(context, listen: false).attendance;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ab("Record Accident/Incident".tr()),
      body: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              navyText('Acceident/Incident type:'.tr()),
              dropDownButton()
            ],
          ),
          Divider(
              // thickness: 1,
              // color: MyColors.color1,
              ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: navyText('d'.tr()),
              ),
              TextArea(
                  label: 'Add Description'.tr(),
                  hint: 'Enter Description'.tr(),
                  controller: accidentController),
            ],
          ),
          Divider(
            thickness: 0.7,
          ),
          navyText('Choose affected children:'.tr()),
          Expanded(
            child: ListView.builder(
              itemCount: myClassChilrenList.length,
              itemBuilder: (context, index) {
                return AttendanceChildtile(
                  index: index,
                  name: myClassChilrenList[index]['fullName'],
                  image: myClassChilrenList[index]['image']['data'],
                  checked: false,
                  attendance: false,
                );
              },
            ),
          ),
          // Divider(
          //   color: MyColors.color1,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //  elevatedButon(text: 'assign all as attendant', onPressed: () {}),
              const SizedBox(
                width: 30,
              ),
              Container(
                margin: const EdgeInsets.only(right: 18, left: 18),
                child: ElevatedButton(
                  onPressed: () {
                    attendList =
                        Provider.of<AppProvider>(context, listen: false)
                            .attendance;
                    addAccident();
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
    );
  }

  dropDownButton() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 4, color: MyColors.color1)),
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: const TextStyle(fontSize: 17),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}
