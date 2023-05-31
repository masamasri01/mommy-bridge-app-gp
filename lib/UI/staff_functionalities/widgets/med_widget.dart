// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/custom_ceckbox.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/core/widgets.dart';

class medDetailsWidget extends StatefulWidget {
  String? childName;
  int? noDoses;
  String? medName;
  int? noDays;
  bool? isDaily;
  String? details;
  String cretaedAt;
  medDetailsWidget({
    Key? key,
    required this.childName,
    required this.noDoses,
    required this.medName,
    required this.noDays,
    this.isDaily = false,
    required this.details,
    required this.cretaedAt,
  }) : super(key: key);

  @override
  State<medDetailsWidget> createState() => _medDetailsWidgetState();
}

class _medDetailsWidgetState extends State<medDetailsWidget> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    // Assuming you have a start date and today's date
    DateTime startDate = DateTime.parse(widget.cretaedAt);
    DateTime today = DateTime.now();

// Calculate the difference between the two dates
    Duration difference = today.difference(startDate);

// Get the number of days as an integer
    int daysLeft = difference.inDays;

    bool isMom = Provider.of<TeacherProvider>(context, listen: false).isMom!;

    return Container(
        //   height: 300,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            //  border: Border.all(color: MyColors.color1),
            boxShadow: myBoxShadow()),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: MyColors.color1,
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                      text: widget.childName! + ' ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.color3,
                          fontSize: 20)),
                  TextSpan(text: 'needs to take '.tr()),
                  TextSpan(
                      text: ' ' + widget.medName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.color4,
                          fontSize: 20)),
                  // TextSpan(text: ' at '.tr()),
                  // TextSpan(
                  //     text: widget.timeStamp,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: MyColors.color3,
                  //         fontSize: 20)),
                  // TextSpan(text: '.'),
                ],
              ),
            ),
            Divider(),
            widget.isDaily ?? true
                ? navyText('This is a daily Meditation'.tr())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navyText('Number of days left:'.tr()),
                      Container(
                        margin: EdgeInsets.all(3),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.color1)),
                        child: Center(
                          child: Text(
                            daysLeft.toString(),
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navyText('Number of doses per day:'.tr()),
                Container(
                  margin: EdgeInsets.all(3),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      border: Border.all(color: MyColors.color1)),
                  child: Center(
                    child: Text(
                      widget.noDoses.toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navyText('This meditation started at:'.tr()),
                Container(
                  margin: EdgeInsets.all(3),
                  height: 33,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      border: Border.all(color: MyColors.color2)),
                  child: Center(
                    child: Text(
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(widget.cretaedAt)),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                widget.isDaily == true
                    ? SizedBox()
                    : navyText('and should be taken for :'.tr() +
                        widget.noDays.toString() +
                        ' days'),
              ],
            ),
            Divider(),
            widget.details != null
                ? Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navyText('Other details/ instructions:'.tr()),
                      Container(
                        margin: EdgeInsets.all(3),
                        height: 33,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            border: Border.all(color: MyColors.color3)),
                        child: Center(
                          child: Text(
                            widget.details!,
                          ),
                        ),
                      ),
                      widget.isDaily == true
                          ? SizedBox()
                          : navyText('and should be taken for :'.tr() +
                              widget.noDays.toString() +
                              ' days'),
                    ],
                  )
                : SizedBox(),
            isMom
                ? SizedBox()
                : Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navyText('Mark as token:'.tr()),
                          CustomCheckBox(
                            value: checked,
                            onChanged: (bool v) {
                              setState(() {
                                checked = v;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
          ],
        ));
  }
}
