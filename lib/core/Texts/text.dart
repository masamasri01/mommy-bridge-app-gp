import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/core/Colors/colors.dart';
//import 'package:google_fonts/google_fonts.dart';

myText(String word) {
  return Text(
    word,
    style: TextStyle(
      fontSize: 20,
    ),
  );
}

boldText(String word) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        word,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

boldWhiteText(String word) {
  return Container(
    margin: EdgeInsets.only(left: 20),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        word,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

boldText2(String word) {
  return Container(
    child: Text(
      word,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

navyText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 20, color: MyColors.color1),
  );
}

grayText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 20, color: Color.fromARGB(155, 83, 82, 82)),
  );
}

pinkText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 20, color: MyColors.color4),
  );
}

boldPinkText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 20, color: MyColors.color4, fontWeight: FontWeight.w800),
  );
}

boldGreenText(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
  );
}

boldRedText(String text) {
  return Text(
    text,
    style:
        TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
  );
}
