// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/UI/Mom_UI/report.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/child_profile_for_mom.dart';
import 'package:gp/UI/Mom_UI/widgets/child_card.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Texts/text.dart';

class MyChildren extends StatefulWidget {
  bool reports;
  MyChildren({
    Key? key,
    this.reports = false,
  }) : super(key: key);

  @override
  _MyChildrenState createState() => _MyChildrenState();
}

class _MyChildrenState extends State<MyChildren> {
  late List mySonsList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MomProvider>(context, listen: false).getMySonsList();
    mySonsList = Provider.of<MomProvider>(context, listen: false).mySonsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('My Children'.tr()),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            boldText('My Children2'.tr()),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: (2.5 / 4),
                children: [
                  for (var e in mySonsList)
                    FutureBuilder<dynamic>(
                      future: Provider.of<MomProvider>(context, listen: false)
                          .getMyChildData(e["_id"]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var childData = snapshot.data!;
                          var teacherName = childData["teacherId"]["name"];
                          // print("Teacher Name: $teacherName");

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.3),
                            height: MediaQuery.of(context).size.width * 0.85,
                            width: MediaQuery.of(context).size.width * 0.46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ChildCard(
                              img: childData['image'] == null
                                  ? Uint8List.fromList(([0, 0]).cast<int>())
                                  : Uint8List.fromList(
                                      (childData['image']['data']).cast<int>()),
                              color: Colors.pink,
                              heading: childData['fullName'],
                              description: "T. " + teacherName,
                              color1: Colors.white,
                              onPressed: () async {
                                await Provider.of<MomProvider>(context,
                                        listen: false)
                                    .getMyChildData(e["_id"]);
                                (widget.reports == false)
                                    ? {
                                        AppRouter.appRouter.goToWidget(
                                          childProfileForMom(childId: e["_id"]),
                                        )
                                      }
                                    : {
                                        AppRouter.appRouter.goToWidget(Report())
                                      };
                              },
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
