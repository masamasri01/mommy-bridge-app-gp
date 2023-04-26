import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';

AppBar ab(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: MyColors.color3,
    centerTitle: true,
    bottomOpacity: 0.4,
  );
}

AppBar ab_noleading(String title) {
  return AppBar(
      title: Text(title),
      backgroundColor: MyColors.color3,
      centerTitle: true,
      bottomOpacity: 0.4,
      automaticallyImplyLeading: false);
}
