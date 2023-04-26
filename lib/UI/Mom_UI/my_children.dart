import 'package:flutter/material.dart';
import 'package:gp/Router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/UI/Mom_UI/child_profile_for_mom.dart';
import 'package:gp/UI/Mom_UI/widgets/child_card.dart';
import 'package:gp/UI/staff_functionalities/child_profile.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/API/my_children.dart';
import 'package:gp/core/Texts/text.dart';

class MyChildren extends StatelessWidget {
  const MyChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('My Children'.tr()),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(children: [
          boldText('m'.tr()),
          Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (2.5 / 4),
                  children: mychildrenList.map((e) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.3),
                      height: MediaQuery.of(context).size.width * 0.85,
                      width: MediaQuery.of(context).size.width * 0.46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ChildCard(
                          img: (e['image']),
                          color: Colors.pink,
                          heading: e['name'],
                          description: "T. : Zeina rayyann",
                          color1: Colors.white,
                          onPressed: () {
                            AppRouter.appRouter
                                .goToWidget(childProfileForMom());
                          }),
                    );
                  }).toList()))
        ]),
      ),
    );
  }
}
