import 'package:flutter/material.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/widgets/child_tile.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/time_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class Meals extends StatefulWidget {
  const Meals({Key? key}) : super(key: key);

  @override
  _Meals createState() => _Meals();
}

class _Meals extends State<Meals> {
// Initial Selected Value
  String dropdownvalue = 'Breakfast';

// List of items in our dropdown menu
  var items = [
    'Breakfast',
    'Lunch',
    'Snack',
    'Milk',
    'Juice',
  ];
  @override
  Widget build(BuildContext context) {
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
              MyTimePicker(text: 'Time of the meal:'.tr()),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: navyText('Choose children:'.tr()),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: childrenList.length,
                  itemBuilder: (context, index) {
                    return ChildTile(
                        index: index,
                        name: childrenList[index]['name'],
                        image: childrenList[index]['image']);
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
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
