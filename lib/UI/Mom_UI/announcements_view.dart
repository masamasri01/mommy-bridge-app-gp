// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Colors/colors.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ab('Announcements'.tr()),
        body: Column(children: [
          Card(
              shadowColor: Colors.black,
              color: Colors.redAccent[1],
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      AnnouncementCard(
                          time: '12/3/2023 12:00am ',
                          subtitle:
                              'Please bring a traditional thoub with your children tomorrow'),
                      AnnouncementCard(
                          time: '12/3/2023 12:00 am ',
                          subtitle:
                              'Please bring a traditional thoub with your children tomorrow'),
                      AnnouncementCard(
                          time: '30/3/2023 12:00 am ',
                          subtitle:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ')
                    ],
                  )))
        ]));
  }
}

class AnnouncementCard extends StatelessWidget {
  String time;
  String subtitle;
  AnnouncementCard({
    Key? key,
    required this.time,
    required this.subtitle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: MyColors.color4,
        elevation: 1,
        child: ListTile(
          //  leading: Icon(Icons.radio_button_checked),
          title: Text(
            time,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(172, 255, 255, 255)),
          ),
          subtitle: Text(subtitle,
              style: TextStyle(
                  color: Color.fromARGB(255, 16, 13, 13), fontSize: 20)),
          trailing: Icon(Icons.safety_check),
        ));
  }
}
