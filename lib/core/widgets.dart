import 'package:flutter/material.dart';

myBoxShadow() {
  return [
    BoxShadow(
      color: Colors.grey.withOpacity(0.2), //color of shadow
      spreadRadius: 5, //spread radius
      blurRadius: 7, // blur radius
      offset: Offset(0, 2), // changes position of shadow
      //first paramerter of offset is left-right
      //second parameter is top to down
    )
  ];
}

backgroundContainer(Widget child) {
  return Material(
      elevation: 1,
      child: Container(
        child: child,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 244, 244, 247)),
      ));
}
