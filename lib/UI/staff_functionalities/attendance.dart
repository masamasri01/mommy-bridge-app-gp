import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/attend_child.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Enter Attendance Details'.tr()),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          navyText('Record absent children'.tr()),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: childrenList.length,
              itemBuilder: (context, index) {
                return AttendanceChildtile(
                    index: index,
                    attendance: true,
                    name: childrenList[index]['name'],
                    image: childrenList[index]['image']);
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
