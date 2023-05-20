import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/child_tile.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Meals extends StatefulWidget {
  const Meals({super.key});

  @override
  _Meals createState() => _Meals();
}

class _Meals extends State<Meals> {
// Initial Selected Value
  String dropdownvalue = 'Breakfast';
  TextEditingController mealNameController = new TextEditingController();

// List of items in our dropdown menu
  var items = [
    'Breakfast',
    'Lunch',
    'Snack',
    'Milk',
    'Juice',
  ];
  late String userId;
  TextEditingController timeController = TextEditingController();
  late String childId;
  List<int?> amount = List.filled(50, 0); //index : amount
  List mychildrenList = [];
  // @override
  // void initState() {
  //   super.initState();
  //   Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

  //   userId = jwtDecodedToken['_id'];
  //   print("id-----------------" + userId);
  //   getMyClassChildrenList(userId);
  // }

  void addMeal() async {
    if (mealNameController.text.isNotEmpty) {
      for (int i = 0; i < mychildrenList.length; i++) {
        var regBody = {
          "mealName": mealNameController.text,
          "mealTime": timeController.text,
          "mealType": dropdownvalue,
          "amount": amount[i] ?? 3,
          "childId": mychildrenList[i]['_id']
        };

        var response = await http.post(Uri.parse(mealAdd),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse['status']);

        if (jsonResponse['status']) {
          // setState(() {
          //   getTodoList(userId);
          // });
        } else {
          print("SomeThing Went Wrong");
        }
      }
    }
    timeController.clear();
    mealNameController.clear();
    Navigator.pop(context);
  }

  // void getMyClassChildrenList(userId) async {
  //   var regBody = {"teacherId": userId};

  //   var response = await http.post(Uri.parse(MyChildrenListGet),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(regBody));
  //   var jsonResponse = jsonDecode(response.body);
  //   print('response json ' + jsonResponse.toString());

  //   setState(() {
  //     mychildrenList = jsonResponse['success'];
  //     for (int i = 0; i < mychildrenList.length; i++) {
  //       amount[i] = 3;
  //     }
  //     print(jsonResponse['success'].toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    mychildrenList = Provider.of<TeacherProvider>(context).myChildrenList;

    List<int> indexSelectedList = List.filled(mychildrenList.length, 0);
    void setIndexSelected(int index, int value) {
      setState(() {
        indexSelectedList[index] = value;
      });
    }

    return Scaffold(
        appBar: ab('Meals'.tr()),
        body: Center(
            child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 230,
                      child: TextField(
                        controller: mealNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Meal Name'.tr(),
                          hintText: 'Enter Name'.tr(),
                        ),
                      ),
                    ),
                    dropDownButton(),
                  ],
                ),
              ),
              MyTimePicker(
                text: 'Time of the meal:'.tr(),
                timeController: timeController,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: navyText('choose amount:'.tr()),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: mychildrenList.length,
                  itemBuilder: (context, index) {
                    return ChildTile(
                        index: index,
                        name: mychildrenList[index]['fullName'],
                        image: mychildrenList[index]['image']);
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        amount =
                            Provider.of<AppProvider>(context, listen: false)
                                .indexSelected;
                        for (int i = 0; i < amount.length; i++) {
                          print(amount[i].toString());
                        }
                        addMeal();
                      },
                      child: const Text('Post').tr(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.color1),
                    ),
                  )),
            ])));
  }

  dropDownButton() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: MyColors.color1)),
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
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
            dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}
