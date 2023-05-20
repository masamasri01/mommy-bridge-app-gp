// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/widgets.dart';

class MyDropdownButton extends StatefulWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  MyDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.white,
        boxShadow: myBoxShadow(),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: MyColors.color1),
      ),
      child: DropdownButton<String>(
        value: widget.value,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 17),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.onChanged(newValue!);
          });
        },
      ),
    );
  }
}
