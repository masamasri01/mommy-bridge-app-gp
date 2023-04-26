import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:gp/core/API/children.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/attend_child.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/text_area.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab("Record Accident/Incident".tr()),
      body: Column(
        children: [
          SizedBox(
            height: 5,
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
                  controller:
                      Provider.of<TeacherProvider>(context).accidentController),
            ],
          ),
          Divider(
            thickness: 0.7,
          ),
          navyText('Choose affected children:'.tr()),
          Expanded(
            child: ListView.builder(
              itemCount: childrenList.length,
              itemBuilder: (context, index) {
                return AttendanceChildtile(
                  index: index,
                  name: childrenList[index]['name'],
                  image: childrenList[index]['image'],
                  checked: false,
                  attendance: false,
                );
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
                margin: const EdgeInsets.only(right: 18),
                child: ElevatedButton(
                  onPressed: () {},
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
