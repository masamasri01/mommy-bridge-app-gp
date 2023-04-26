import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:easy_localization/easy_localization.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
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
                      DateTime.now(),
                      height: 100,
                      width: 80,
                      selectionColor: Theme.of(context).primaryColor,
                      daysCount: 32,
                      dateTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      onDateChange: (selectedDate) {
                        // prov.changeSelectedDate(selectedDate);
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                FeedCard(),
                FeedCard(),
                FeedCard(),
              ],
            ),
          ),
        ));
  }
}

class FeedCard extends StatelessWidget {
  const FeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      //  elevation: 1,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        //  height: 368,
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.grey),
        //   borderRadius: BorderRadius.circular(10),
        // ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/R.2998a6cd018195303ab36ca50f881493?rik=najAV1%2fipGy4lQ&pid=ImgRaw&r=0'),
              ),
              title: navyText(
                'Rahaf Omar',
              ),
              subtitle: Text('3:02 am',
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
          Text('we are having so much fun and knowledge',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(fontSize: 17)),
          SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.vwyZx_tyS_PYgqdZ5PP_eAHaE8?pid=ImgDet&rs=1',
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
