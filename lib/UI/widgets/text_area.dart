// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:gp/core/Colors/colors.dart';

class TextArea extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;
  TextArea({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            fillColor: Colors.white,
            focusColor: MyColors.color4,
            border: OutlineInputBorder(),
            labelText: this.label,
            hintText: this.hint,
            filled: true),
        controller: controller,
        maxLines: 5,
        // onChanged: (v) {
        //   setState(() {
        //     announcement = v;
        //   });
        // },
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;
  MyTextField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            focusColor: MyColors.color4,
            border: OutlineInputBorder(),
            labelText: this.label,
            hintText: this.hint,
            filled: true,
            fillColor: Colors.white),
        controller: controller,
//maxLines: 5,
        // onChanged: (v) {
        //   setState(() {
        //     announcement = v;
        //   });
        // },
      ),
    );
  }
}
