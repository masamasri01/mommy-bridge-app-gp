import 'package:flutter/material.dart';
import 'package:gp/Education/add_material.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/Feed.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph_leader.dart';
import 'package:gp/UI/staff_functionalities/homeworks.dart';
import 'package:gp/UI/staff_functionalities/moms.dart';
import 'package:gp/UI/widgets/appbar_widget.dart';
import 'package:gp/UI/staff_functionalities/accident.dart';
import 'package:gp/UI/staff_functionalities/activities.dart';
import 'package:gp/UI/staff_functionalities/attendance.dart';
import 'package:gp/UI/staff_functionalities/chat.dart';
import 'package:gp/UI/staff_functionalities/meals.dart';
import 'package:gp/UI/staff_functionalities/med.dart';
import 'package:gp/UI/staff_functionalities/naps.dart';
import 'package:gp/UI/widgets/drawer.dart';
import 'package:gp/UI/widgets/gridtile.dart';
import 'package:easy_localization/easy_localization.dart';

class StaffHomePage extends StatelessWidget {
  StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context: context),
      // drawer: drawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: GridView.count(crossAxisCount: 3, children: [
                gridTile(
                    icon_: const Icon(Icons.food_bank_outlined),
                    onPressed: routMeals,
                    title: 'Meals'.tr()),
                gridTile(
                    icon_: const Icon(Icons.bedroom_parent_outlined),
                    onPressed: routNaps,
                    title: 'Naps'.tr()),
                gridTile(
                    icon_: const Icon(Icons.bedroom_baby_outlined),
                    onPressed: routAct,
                    title: 'Activities'.tr()),
                gridTile(
                    icon_: const Icon(Icons.announcement_outlined),
                    onPressed: routAnn,
                    title: 'Announce'.tr()),
                gridTile(
                    icon_: const Icon(Icons.medication_liquid_sharp),
                    onPressed: routMed,
                    title: 'Medicine'.tr()),
                gridTile(
                    icon_: const Icon(Icons.post_add),
                    onPressed: routFeed,
                    title: 'Posts'.tr()),
                gridTile(
                    icon_: const Icon(Icons.table_view),
                    onPressed: routAtt,
                    title: 'Attendance'.tr()),
                gridTile(
                    icon_: const Icon(Icons.medical_services_outlined),
                    onPressed: routAcc,
                    title: 'Accindent'.tr()),
                gridTile(
                    icon_: const Icon(Icons.list),
                    onPressed: routMom,
                    title: 'Moms'.tr()),
                gridTile(
                    icon_: const Icon(Icons.book_sharp),
                    onPressed: routMaterial,
                    title: 'Material'.tr()),
                gridTile(
                    icon_: const Icon(Icons.book_sharp),
                    onPressed: routHomework,
                    title: 'Homeworks'.tr()),
                gridTile(
                    icon_: const Icon(Icons.book_sharp),
                    onPressed: routAnalysis,
                    title: 'Analysis'.tr()),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  routMom() {
    AppRouter.appRouter.goToWidget(const Moms());
  }

  routAnalysis() {
    AppRouter.appRouter.goToWidget(LeaderGraph());
  }

  routMaterial() {
    AppRouter.appRouter.goToWidget(const AddMatrial());
  }

  routHomework() {
    AppRouter.appRouter.goToWidget(const Homework());
  }

  routMeals() {
    AppRouter.appRouter.goToWidget(const Meals());
  }

  void routNaps() {
    AppRouter.appRouter.goToWidget(const Naps());
  }

  void routAct() {
    AppRouter.appRouter.goToWidget(const Activities());
  }

  void routChat() {
    AppRouter.appRouter.goToWidget(const Chat());
  }

  void routAcc() {
    AppRouter.appRouter.goToWidget(Accident());
  }

  void routAnn() {
    // AppRouter.appRouter.goToWidget(Announcements());
    AppRouter.appRouter.showAddAnnouncement();
  }

  void routAtt() {
    AppRouter.appRouter.goToWidget(const Attendance());
  }

  void routMed() {
    AppRouter.appRouter.goToWidget(const Medicine());
  }

  void routFeed() {
    AppRouter.appRouter.goToWidget(Feed());
  }
}