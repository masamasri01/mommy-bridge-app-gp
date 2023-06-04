// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ChildTileLeaderboard extends StatelessWidget {
  String name;
  Uint8List? image;
  int index;
  int points;

  ChildTileLeaderboard({
    Key? key,
    required this.name,
    required this.image,
    required this.index,
    required this.points,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 9, left: 16, right: 17),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
              color: (getcolor()), width: 2.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
          color: Color.fromARGB(156, 255, 255, 255)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage:
                      MemoryImage(Uint8List.fromList((image!).cast<int>())),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(
                    // color: Color.fromARGB(255, 109, 107, 107),
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
              SizedBox(
                width: 80,
              ),
              // Checkbox(
              //   value: false,
              //   onChanged: ((value) {}),
              // )
            ],
          ),
          boldPinkText("${this.points.toString()} " + "Points".tr())
        ],
      ),
    );
  }

  getcolor() {
    int numm = (index + 1) % 2;
    if (numm == 0)
      return MyColors.color1;
    else if (numm == 1) return MyColors.color3;
  }
}
