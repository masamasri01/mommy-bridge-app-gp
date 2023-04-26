import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/UI/Mom_UI/widgets/allergies_widget.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/UI/widgets/dropdownbutton.dart';
import 'package:gp/UI/widgets/text_area.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/API/my_children.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Allergies extends StatelessWidget {
  const Allergies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Allergies'.tr()),
      body: Consumer<MomProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                  label: 'Allergy'.tr(),
                  hint: 'add allergy'.tr(),
                  controller: provider.allergyNameController),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navyText('Assign this allergy for:'.tr()),
                  myDropdownButton(
                      val: mychildrenList[0]['name'],
                      itemss: mychildrenList
                          .map((e) => e['name'].toString())
                          .toList()),
                ],
              ),
              Divider(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: elevatedButon(text: 'Add'.tr(), onPressed: () {})),
              Divider(),
              Column(
                  children: childrenList.map((e) {
                return AllergiesWidget(
                    Allergies: e['allergies'], childName: e['name']);
              }).toList())
            ],
          ),
        );
      }),
    );
  }
}
