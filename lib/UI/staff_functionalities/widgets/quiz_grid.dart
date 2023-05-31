// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/staff_functionalities/meals.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';

class QuizGridTile extends StatelessWidget {
  final VoidCallback onPressed;
  bool edit;
  String title;
  QuizGridTile({
    Key? key,
    required this.onPressed,
    this.edit = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(children: [
        Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(10),
            height: 210,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                border: Border.all(
                    color: MyColors.color3,
                    width: 2.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                gradient: AppGradients.linear,
                color: MyColors.color4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridTile(
                    child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: MyColors.white),
                  child: Center(child: boldText(title)),
                )),
                // Text(
                //   title,
                //   style: TextStyle(
                //       fontSize: 17,
                //       color: MyColors.white,
                //       fontWeight: FontWeight.bold),
                // ),
              ],
            )),
        edit == true
            ? Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Color.fromARGB(255, 233, 233, 233),
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ),
              )
            : SizedBox()
      ]),
    );
  }
}

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color.fromRGBO(136, 55, 101, 0.682),
    // MyColors.color2,
    MyColors.color1
  ], stops: [
    0.0,
    0.695,
  ], transform: GradientRotation(2.13959913 * pi));
}
