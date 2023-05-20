import 'package:flutter/material.dart';
import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/UI/Mom_UI/child_profile_for_mom.dart';
import 'package:gp/UI/Mom_UI/widgets/child_card.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:provider/provider.dart';

class MyChildren extends StatefulWidget {
  MyChildren({Key? key}) : super(key: key);

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
            boldText('m'.tr()),
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
                          print("Teacher Name: $teacherName");

                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.3),
                            height: MediaQuery.of(context).size.width * 0.85,
                            width: MediaQuery.of(context).size.width * 0.46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ChildCard(
                              img: childData['image'],
                              color: Colors.pink,
                              heading: childData['fullName'],
                              description: "T. " + teacherName ?? "",
                              color1: Colors.white,
                              onPressed: () async {
                                Provider.of<MomProvider>(context, listen: false)
                                    .getMyChildData(e["_id"]);
                                AppRouter.appRouter.goToWidget(
                                  childProfileForMom(childId: e["_id"]),
                                );
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
