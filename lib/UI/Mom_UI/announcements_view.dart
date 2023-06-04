// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/Providers/Mom_provider.dart';

import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:provider/provider.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    List announcements =
        Provider.of<MomProvider>(context, listen: false).announcementsList ??
            [];
    return Scaffold(
      appBar: ab('Announcements'.tr()),
      body: Column(
        children: [
          Flexible(
            // Wrap the ListView.builder with Flexible
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  final announcement = announcements[index];

                  return AnnouncementCard(
                    subtitle: (announcement['announce']),
                    time: (announcement['createdAt']),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
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
    final formattedDateTime =
        DateFormat.yMMMd().add_jm().format(DateTime.parse(time));
    return Card(
        color: MyColors.color4,
        elevation: 1,
        child: ListTile(
          //  leading: Icon(Icons.radio_button_checked),
          title: Text(
            formattedDateTime,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(172, 58, 56, 56)),
          ),
          subtitle: Text(subtitle,
              style: TextStyle(
                  color: Color.fromARGB(255, 223, 215, 215), fontSize: 20)),
          trailing: Icon(Icons.safety_check),
        ));
  }
}
