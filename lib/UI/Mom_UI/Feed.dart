// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Texts/text.dart';

import 'package:intl/intl.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TeacherProvider>(builder: (context, provider, x) {
      DateTime selectedDate = provider
          .selectedDate; // Replace with the selected date from the time picker

      return Scaffold(
        appBar: ab_noleading('Feed'.tr()),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  margin: const EdgeInsets.all(1),
                  child: DatePicker(
                    DateTime.parse('2023-05-01 20:18:04Z'),
                    height: 100,
                    width: 80,
                    selectionColor: Theme.of(context).primaryColor,
                    daysCount: 32,
                    dateTextStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    onDateChange: (selectedDate) {
                      // Update the selectedDate when the user selects a new date
                      provider.setSelectedDate(selectedDate);
                    },
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder<List<Activity>>(
                  future: provider.getActivitiesByDate(selectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final activities = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: activities.length,
                        itemBuilder: (context, index) {
                          final activity = activities[index];
                          return FeedCard(activity: activity);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text('No activities found');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FeedCard extends StatelessWidget {
  final Activity activity;

  const FeedCard({Key? key, required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List image = Uint8List.fromList([0, 0].cast<int>());
    if (activity.profileImage != null) {
      List<dynamic> imageData = activity.profileImage;
      image = Uint8List.fromList(imageData.cast<int>());
    }
    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: MemoryImage(image),
              ),
              title: navyText(activity.teacherName),
              subtitle: Text(
                  DateFormat('h:mm a').format(activity.timestamp).toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey)),
              trailing: IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).iconTheme.color,
                  ))),
          Text(activity.description,
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(fontSize: 17)),
          SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              activity.image,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.thumb_up,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.comment,
                          color: Theme.of(context).iconTheme.color))
                ],
              ),
              IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.telegram,
                    color: Theme.of(context).iconTheme.color,
                  ))
            ],
          ),
          Divider(
            thickness: 1,
          )
        ]),
      ),
    );
  }
}

class Activity {
  final String description;
  final Uint8List image;
  final DateTime timestamp;
  final String teacherName;
  final List<dynamic> profileImage;
  Activity(
      {required this.description,
      required this.image,
      required this.timestamp,
      required this.teacherName,
      required this.profileImage});
}
