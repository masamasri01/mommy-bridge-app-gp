// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gp/core/Colors/colors.dart';
//import 'package:gp/Texts/text.dart';

class elevatedButon extends StatelessWidget {
  String text;
  final VoidCallback onPressed;
  elevatedButon({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Align(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        //  alignment: Alignment.bottomLeft,
      ),
      style: ElevatedButton.styleFrom(backgroundColor: MyColors.color4),
    );
  }
}
