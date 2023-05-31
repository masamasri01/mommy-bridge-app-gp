import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:gp/UI/widgets/text_area.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ab('Add Activity'.tr()),
      body: Consumer<TeacherProvider>(builder: (context, provider, x) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    backgroundContainer(
                      Column(
                        children: [
                          Align(
                            child: navyText('Attach an Image'.tr()),
                            alignment: Alignment.centerLeft,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              provider.pickImageForActivity(
                                                  ImageSource.camera);
                                              // selectImage();
                                            },
                                            icon: const Icon(Icons.camera),
                                            label: navyText(
                                                'Select from Camera'.tr())),
                                        const Divider(),
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              //selectImage();
                                              provider.pickImageForActivity(
                                                  ImageSource.gallery);
                                            },
                                            icon: const Icon(Icons.image),
                                            label: navyText(
                                                'Select from Gallery'.tr())),
                                      ],
                                    );
                                  });
                            },
                            child: provider.activityImageFile == null
                                ? Center(
                                    child: Image.asset(
                                    'lib/core/images/placeholder.png',
                                    fit: BoxFit.fitWidth,
                                  ))
                                : Image.file(
                                    provider.activityImageFile!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    backgroundContainer(
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: navyText(
                                'Add A Desription for this Activity'.tr()),
                          ),
                          Container(
                              //  padding: EdgeInsets.all(10),
                              child: TextArea(
                                  label: 'Add Description of the activity'.tr(),
                                  hint: 'Enter Description'.tr(),
                                  controller: provider.description)),
                        ],
                      ),
                    ),

                    //(height: 14),

                    // InkWell(
                    //   onTap: () {
                    //     provider.pickImageForActivity();
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(10),
                    //     height: 200,
                    //     width: 300,
                    //     color: MyColors.color3,
                    //     child: provider.activityImageFile == null
                    //         ? const Center(
                    //             child: Icon(Icons.camera),
                    //           )
                    //         : Image.file(
                    //             provider.activityImageFile!,
                    //             fit: BoxFit.cover,
                    //           ),
                    //   ),
                    // ),

                    Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              await provider.uploadImage();
                              Navigator.pop(context);
                              //   provider.setactivityImageFileNULL();
                            },
                            child: Text('Post'.tr()),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.color1),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
