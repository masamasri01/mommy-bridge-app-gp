// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';

import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/widgets/custom_ceckbox.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/core/widgets.dart';

class medDetailsWidget extends StatefulWidget {
  String childName;
  int noDoses;
  String medName;
  String timeStamp;
  int noDays;
  bool isDaily;
  medDetailsWidget({
    Key? key,
    this.isDaily = false,
    required this.childName,
    required this.noDoses,
    required this.medName,
    required this.timeStamp,
    required this.noDays,
  }) : super(key: key);

  @override
  State<medDetailsWidget> createState() => _medDetailsWidgetState();
}

class _medDetailsWidgetState extends State<medDetailsWidget> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
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
                      text: widget.childName + ' ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.color3,
                          fontSize: 20)),
                  TextSpan(text: 'needs to take '.tr()),
                  TextSpan(
                      text: ' ' + widget.medName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.color4,
                          fontSize: 20)),
                  TextSpan(text: ' at '.tr()),
                  TextSpan(
                      text: widget.timeStamp,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.color3,
                          fontSize: 20)),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            Divider(),
            widget.isDaily
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
                            widget.noDoses.toString(),
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
