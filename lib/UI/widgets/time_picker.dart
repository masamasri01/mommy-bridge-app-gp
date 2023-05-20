// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTimePicker extends StatelessWidget {
  String text;
  TextEditingController timeController;
  MyTimePicker({
    Key? key,
    required this.text,
    required this.timeController,
  }) : super(key: key);

  String value = "";
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    timeController.text = TimeOfDay.now().format(context);
    DateTime todayAt8AM = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0);

    return InkWell(
      child: Container(
        width: size.width * 0.7,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffdbe2ea)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0a2c2738),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: TextField(
          controller: timeController,
          readOnly: true,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () async {
                var time = await showTimePicker(
                  initialEntryMode: TimePickerEntryMode.inputOnly,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Color(0xffE5E0A1),
                          onPrimary: Colors.black,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialTime: text == 'Entery Time'
                      ? TimeOfDay.fromDateTime(todayAt8AM)
                      : TimeOfDay.now(),
                );

                print(time!.format(context));
                timeController.text = time.format(context);
                // scheduleAlarm();
              },
              icon: const Icon(
                Icons.add_alert,
                //  color: Colors.deepPurple,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13,
              color: Color.fromARGB(255, 103, 106, 110),
            ),
          ),
          onChanged: (text) {
            value = text;
            print(value);
          },
        ),
      ),
    );
  }
}
