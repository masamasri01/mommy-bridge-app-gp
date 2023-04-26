import 'package:flutter/material.dart';
import 'package:gp/UI/staff_functionalities/widgets/med_widget.dart';

import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';

class Medicine extends StatefulWidget {
  const Medicine({super.key});

  @override
  State<Medicine> createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Medicine Details'.tr()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            medDetailsWidget(
              childName: 'Moen Abu Shamat',
              noDoses: 4,
              medName: 'Panadol',
              timeStamp: '2:01 am',
              noDays: 2,
              isDaily: true,
            ),
            medDetailsWidget(
              childName: 'Yaman Abu Shamat',
              noDoses: 4,
              medName: 'Panadol',
              timeStamp: '2:01 am',
              noDays: 3,
            ),
            medDetailsWidget(
              childName: 'Huda Ameer',
              noDoses: 2,
              medName: 'Panadol',
              timeStamp: '1:02 am',
              noDays: 2,
              isDaily: true,
            ),
          ],
        ),
      ),
    );
  }
}
