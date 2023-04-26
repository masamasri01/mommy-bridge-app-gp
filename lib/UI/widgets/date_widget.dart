import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/UI/Mom_UI/Activities.dart';

class ShowDate extends StatelessWidget {
  const ShowDate({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20, bottom: 15),
      child: Text(
        getDateToday(today),
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 130, 130, 130)),
      ),
    );
  }
}
