import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/staff_functionalities/meals.dart';

class gridTile extends StatelessWidget {
  Icon icon_;
  final VoidCallback onPressed;
  String title;
  gridTile({required this.icon_, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(10),
        height: 25,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            border: Border.all(
                color: MyColors.color3, width: 2.0, style: BorderStyle.solid),
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  color: MyColors.white),
              child: IconButton(
                  color: MyColors.color4,
                  icon: icon_,
                  iconSize: 35,
                  onPressed: onPressed),
            )),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: MyColors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color.fromRGBO(130, 87, 229, 0.695),
    // MyColors.color2,
    MyColors.color1
  ], stops: [
    0.0,
    0.695,
  ], transform: GradientRotation(2.13959913 * pi));
}
