import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph.dart';
import 'package:gp/UI/staff_functionalities/Analysis/leaderboard.dart';
import 'package:easy_localization/easy_localization.dart';

class LeaderGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () => Navigator.maybePop(context),
            ),
            title: Text(
              "Analysis".tr(),
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            bottomOpacity: 0.9,
            elevation: 0.3,
            backgroundColor: Colors.white,
            bottom: TabBar(
                indicatorColor: Color.fromRGBO(154, 167, 255, .8),
                indicatorWeight: 10,
                unselectedLabelColor: Colors.grey,
                labelColor: Color.fromRGBO(154, 167, 255, .8),
                tabs: [
                  Tab(
                    text: 'Played Times / Game'.tr(),
                  ),
                  Tab(
                    text: 'Leaderboard'.tr(),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Analysis(),
            Leaderboard(),
          ])),
    );
  }
}
