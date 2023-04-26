// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/widgets.dart';

class myDropdownButton extends StatefulWidget {
  String val;
  List<String> itemss;
  myDropdownButton({
    Key? key,
    required this.val,
    required this.itemss,
  }) : super(key: key);

  @override
  State<myDropdownButton> createState() => _myDropdownButtonState();
}

class _myDropdownButtonState extends State<myDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: MyColors.white,
          boxShadow: myBoxShadow(),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: MyColors.color1)),
      child: DropdownButton(
        // Initial Value
        value: widget.val,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.itemss.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: const TextStyle(fontSize: 17),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            widget.val = newValue!;
          });
        },
      ),
    );
  }
}
