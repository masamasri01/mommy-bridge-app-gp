// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/UI/Mom_UI/MomProfile.dart';
import 'package:gp/UI/staff_functionalities/widgets/med_widget.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:gp/UI/widgets/dropdownbutton.dart';

class MedicineDetails extends StatefulWidget {
  bool isMom;
  MedicineDetails({
    Key? key,
    this.isMom = true,
  }) : super(key: key);

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  late List mySonsList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<MomProvider>(context, listen: false).getMySonsList();
    mySonsList = Provider.of<MomProvider>(context, listen: false).mySonsList;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = mySonsList[0]["fullName"];

    return Consumer<MomProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: ab('Medicine'.tr()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Add Medication'.tr()),
                    content: SafeArea(
                      child: SizedBox(
                        width: 400,
                        height: 550,
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Medicine name:'.tr()),
                              TextField(
                                controller: provider.medicineNameC,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Daily Medication?'.tr()),
                                  Checkbox(
                                      value: provider.dailyMed,
                                      onChanged: (v) {
                                        setState(() {
                                          provider.setDailyMed(v!);
                                        });
                                      })
                                ],
                              ),
                              provider.dailyMed
                                  ? SizedBox()
                                  : Column(
                                      children: [
                                        Text('For how many days?'.tr()),
                                        TextField(
                                          keyboardType: TextInputType.number,
                                          controller: provider.noDaysC,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                              Text('How many doses per days?'.tr()),
                              TextField(
                                keyboardType: TextInputType.number,
                                controller: provider.noDoses,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Assign this allergy for:'.tr()),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                child: MyDropdownButton(
                                  value: dropdownvalue,
                                  items: mySonsList
                                      .map((e) => e['fullName'].toString())
                                      .toList(),
                                  onChanged: (String newValue) {
                                    dropdownvalue = newValue;
                                    for (var element in mySonsList) {
                                      if (element["fullName"] == newValue) {
                                        provider
                                            .setChildChosenId(element["_id"]);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('More details?'.tr()),
                              TextField(
                                controller: provider.details,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  child: elevatedButon(
                                      text: 'Add'.tr(),
                                      onPressed: () {
                                        provider.addMedicine();
                                        provider.fetchMedicines();
                                        Navigator.pop(context);
                                      })),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            );
          },
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
        /////////////*************************************** */
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: FutureBuilder<List<dynamic>>(
            future: provider.getMed(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error occurred: ${snapshot.error}'));
              } else {
                final medicines = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = medicines[index];
                    final childName =
                        'Yara Jabr'; // Provide the actual child name
                    final medName = medicine[
                        'medicineName']; // Assuming 'medicineName' is the key for the medicine name
                    final details = medicine[
                        'details']; // Assuming 'timestamps' is the key for the timestamp
                    final noDays = medicine[
                        'noDays']; // Assuming 'noDays' is the key for the number of days
                    final noDoses = medicine[
                        'noDoses']; // Assuming 'noDoses' is the key for the number of doses
                    final isDaily = medicine[
                        'daily']; // Assuming 'daily' is the key for the daily flag
                    final createdAt = medicine['createdAt'];
                    return medDetailsWidget(
                      childName: childName,
                      noDoses: noDoses,
                      medName: medName,
                      noDays: noDays,
                      isDaily: isDaily,
                      details: details,
                      cretaedAt: createdAt,
                    );
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }
}
