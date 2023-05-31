import 'package:flutter/material.dart';
import 'package:gp/UI/staff_functionalities/widgets/childtile_2.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/date_widget.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ActivitiesFeed extends StatelessWidget {
  const ActivitiesFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 247, 247),
      appBar: ab_noleading('Activities'.tr()),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(9, 5, 9, 0),
        child: Column(
          children: [
            Column(
              children: [
                ShowDate(),
                NapPost(
                    name: 'Yazeed Jabr',
                    image: childrenList[0]['image'],
                    startTime: '2:09pm',
                    endTime: '3:09pm'),
                MealPost(name: 'Yazeed Jabr', image: childrenList[2]['image']),
                AccidentPost(
                    name: 'Yara Jabr',
                    time: '5:00pm',
                    image: childrenList[0]['image'],
                    type: 'Fall',
                    desc: 'lorem ispum lore ismum'),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class NapPost extends StatelessWidget {
  String name;
  String image;
  String startTime;
  String endTime;
  NapPost({
    Key? key,
    required this.name,
    required this.image,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(
                      Icons.bed,
                      size: 35,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Nap'.tr(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Nap started at:'.tr()), grayText(startTime)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Nap Ended at:'.tr()), grayText(endTime)],
            ),
            const SizedBox(
              height: 8,
            ),
            ChildTile2(index: 0, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }
}

class MealPost extends StatelessWidget {
  String name;
  String image;

  MealPost({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.food_bank_outlined,
                          size: 35,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Meal'.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                grayText('4:09am')
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Meal name:'.tr()), navyText('Eggs')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Meal type:'.tr()), navyText('Breakfast')],
            ),
            const SizedBox(
              height: 7,
            ),
            ChildTile2(index: 1, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }
}

class AccidentPost extends StatelessWidget {
  String name;
  String time;
  String image;
  String type;
  String desc;
  AccidentPost({
    Key? key,
    required this.name,
    required this.time,
    required this.image,
    required this.type,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.food_bank_outlined,
                        size: 35,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Accident/Incident'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              grayText(time)
            ]),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Accident type:'.tr()), navyText(type)],
            ),
            navyText(desc),
            ChildTile2(index: 2, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }
}

String getDateToday(DateTime today) {
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];

  var currentMon = today.month;
  String dateStr =
      "${today.day} ${months[currentMon - 1].toString().toUpperCase()}, ${today.year}";
  return dateStr;
}
