// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/core/widgets.dart';

class AllergiesWidget extends StatelessWidget {
  List<String> Allergies;
  String childName;
  AllergiesWidget({
    Key? key,
    required this.Allergies,
    required this.childName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            pinkText(childName),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Allergies.map((e) => RichText(
                        text: TextSpan(
                            text: '● ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.color1,
                                fontSize: 16),
                            children: <TextSpan>[
                          TextSpan(text: e),
                        ]))).toList())
          ],
        ));
  }
}
