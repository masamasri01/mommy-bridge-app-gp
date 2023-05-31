// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/UI/staff_functionalities/widgets/childtile_2.dart';
import 'package:gp/UI/widgets/custom_ceckbox.dart';
import 'package:provider/provider.dart';

class AttendanceChildtile extends StatefulWidget {
  String? name;
  List image;
  int index;
  bool? checked;
  bool? attendance;
  AttendanceChildtile({
    Key? key,
    required this.name,
    required this.image,
    required this.index,
    this.checked = true,
    this.attendance = false,
  }) : super(key: key);

  @override
  State<AttendanceChildtile> createState() => _AttendanceChildtileState();
}

class _AttendanceChildtileState extends State<AttendanceChildtile> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context)
        .setattendance(widget.index, widget.checked!);
    return Column(
      children: [
        Row(
          children: [
            CustomCheckBox(
                value: widget.checked!,
                onChanged: (value) {
                  setState(() {
                    widget.checked = value;
                  });
                  // Provider.of<AppProvider>(context)
                  //     .setattendance(widget.index, widget.checked!);
                }),
            ChildTile2(
              index: this.widget.index,
              name: this.widget.name,
              image: this.widget.image,
              attendance: this.widget.attendance,
            )
          ],
        ),
      ],
    );
  }
}
