import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/Education/Educational_material.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/widgets/child_card.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/API/my_children.dart';

class PickAChild extends StatelessWidget {
  const PickAChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('My Children'),
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(children: [
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
                                .goToWidget(EducationalMaterial());
                          }),
                    );
                  }).toList()))
        ]),
      ),
    );
  }
}
