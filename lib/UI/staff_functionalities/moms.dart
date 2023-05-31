import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/UI/Mom_UI/child_profile_for_mom.dart';
import 'package:gp/UI/Mom_UI/widgets/child_card.dart';
import 'package:gp/UI/staff_functionalities/child_profile.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/API/my_children.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:provider/provider.dart';

class Moms extends StatelessWidget {
  Moms({super.key});
  List myClassChildrenList = [];
  @override
  Widget build(BuildContext context) {
    myClassChildrenList =
        Provider.of<TeacherProvider>(context, listen: false).myChildrenList;
    return Scaffold(
      appBar: ab('Moms'.tr()),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(children: [
          boldText('m'.tr()),
          Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (2.5 / 4),
                  children: myClassChildrenList.map((e) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.3),
                      height: MediaQuery.of(context).size.width * 0.85,
                      width: MediaQuery.of(context).size.width * 0.46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ChildCard(
                          img: (e['image'] == null
                              ? Uint8List.fromList(([0, 0]).cast<int>())
                              : Uint8List.fromList(
                                  (e['image']['data']).cast<int>())),
                          color: Colors.pink,
                          heading: e['fullName'],
                          description: "",
                          color1: Colors.white,
                          onPressed: () async {
                            // await Provider.of<TeacherProvider>(context,
                            //         listen: false)
                            //     .getMyChildData(e["_id"]);
                            AppRouter.appRouter.goToWidget(childProfileForMom(
                              childId: e["_id"],
                              forMom: false,
                            ));
                          }),
                    );
                  }).toList()))
        ]),
      ),
    );
  }
}
