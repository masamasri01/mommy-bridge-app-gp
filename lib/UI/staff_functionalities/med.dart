import 'package:flutter/material.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/staff_functionalities/widgets/med_widget.dart';

import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<TeacherProvider>(
        builder: (context, provider, x) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: FutureBuilder<List<dynamic>>(
              future: provider.getMed(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error occurred: ${snapshot.error}'));
                } else {
                  final medicines = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (context, index) {
                      final medicine = medicines[index];

                      final medName = medicine[
                          'medicineName']; // Assuming 'medicineName' is the key for the medicine name
                      final details = medicine[
                          'details']; // Assuming 'medicineName' is the key for the medicine name

                      final noDays = medicine[
                          'noDays']; // Assuming 'noDays' is the key for the number of days
                      final noDoses = medicine[
                          'noDoses']; // Assuming 'noDoses' is the key for the number of doses
                      final isDaily = medicine[
                          'daily']; // Assuming 'daily' is the key for the daily flag
                      final createdAt = medicine['createdAt'];
                      return FutureBuilder<dynamic>(
                        future: provider.getMyChildName(medicine[
                            'childId']), // Fetch the child name asynchronously
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error occurred: ${snapshot.error}');
                          } else {
                            final childName = snapshot.data ?? '';

                            return medDetailsWidget(
                              childName: childName,
                              noDoses: noDoses,
                              medName: medName,
                              noDays: noDays,
                              isDaily: isDaily,
                              details: details,
                              cretaedAt: createdAt,
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
