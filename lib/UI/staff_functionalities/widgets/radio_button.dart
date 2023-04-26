import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(RadioModel(false, '◉', 'Full.'.tr()));
    sampleData.add(RadioModel(false, '◑', 'Half.'.tr()));
    sampleData.add(RadioModel(false, '◔', 'Quarter.'.tr()));
    sampleData.add(RadioModel(false, 'o', 'Nothing.'.tr()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },
            child: RadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            //padding: EdgeInsets.only(bottom: 5),
            height: 30.0,
            width: 30.0,

            // padding: EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 27.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected ? MyColors.color1 : Colors.transparent,
              border: Border.all(
                  width: .5,
                  color: _item.isSelected ? Colors.blueAccent : Colors.grey),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0),
            child: Text(
              _item.text,
            ),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
