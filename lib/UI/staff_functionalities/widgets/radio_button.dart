// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/App_provider.dart';
import 'package:gp/core/Colors/colors.dart';

class CustomRadio extends StatefulWidget {
  int index;
  CustomRadio({
    Key? key,
    required this.index,
  }) : super(key: key);
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
    sampleData.add(RadioModel(false, '●', 'Full.'.tr()));
    sampleData.add(RadioModel(false, '◑', 'Half.'.tr()));
    sampleData.add(RadioModel(false, '◔', 'Quarter.'.tr()));
    sampleData.add(RadioModel(false, 'O', 'Nothing.'.tr()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int idx) {
          return InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[idx].isSelected = true;
              });
              Provider.of<AppProvider>(context, listen: false)
                  .setIndexSelected(widget.index, idx);
            },
            child: RadioItem(sampleData[idx]),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            //padding: EdgeInsets.only(bottom: 5),
            width: 35,
            alignment: Alignment.center,
            // padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(_item.buttonText,
                style: TextStyle(
                    color: _item.isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27.0)),
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
