// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gp/Education/pick_a_child_page.dart';
import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/UI/Mom_UI/announcements_view.dart';
import 'package:gp/UI/Mom_UI/mom_allergies.dart';
import 'package:gp/UI/Mom_UI/mom_medicine.dart';
import 'package:gp/UI/Mom_UI/mom_preferences.dart';
import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
import 'package:gp/UI/Mom_UI/my_children.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'package:gp/UI/staff_functionalities/moms.dart';
import 'package:gp/UI/widgets/appbar_widget.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gp/settings_controller.dart/settingscontroller.dart';
import 'package:provider/provider.dart';

class MomProfileView extends StatelessWidget {
  const MomProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageData =
        Provider.of<MomProvider>(context).momData['image']['data'];
    Uint8List image = Uint8List.fromList(imageData.cast<int>());
    return Scaffold(
        appBar: AppBarWidget(
          context: context,
          image: image,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 15,
          ),
          child: Column(children: [
            // MomComand(
            //   title: 'Activities',
            //   subtitle: "Click to see your children's updates",
            //   icon: Icon(Icons.motorcycle_outlined),
            //   color: MyColors.color2,
            // ),
            MomComand(
              title: 'My Details'.tr(),
              subtitle: "edit your details".tr(),
              icon: Icon(Icons.medication_outlined),
              color: MyColors.color2,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(MomProfile());
              }),
            ),
            MomComand(
              title: 'My Children'.tr(),
              subtitle: "",
              icon: Icon(Icons.medication_outlined),
              color: MyColors.color2,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(MyChildren());
              }),
            ),
            MomComand(
              title: 'Medicine'.tr(),
              subtitle: "Add medicine details for your children".tr(),
              icon: Icon(Icons.medication_outlined),
              color: MyColors.color2,
              onPressed: (() async {
                await Provider.of<MomProvider>(context, listen: false)
                    .fetchMedicines();
                AppRouter.appRouter.goToWidget(MedicineDetails());
              }),
            ),

            MomComand(
              title: 'Announcements'.tr(),
              subtitle: "Check if there's an important announcement".tr(),
              icon: Icon(Icons.announcement),
              color: MyColors.color2,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(AnnouncementView());
              }),
            ),
            MomComand(
              title: 'Monthly Reports'.tr(),
              subtitle: "".tr(),
              icon: Icon(Icons.announcement),
              color: MyColors.color2,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(MyChildren(
                  reports: true,
                ));
              }),
            ),
            MomComand(
              title: 'Homeworks'.tr(),
              subtitle: "".tr(),
              icon: Icon(Icons.announcement),
              color: MyColors.color2,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(MyChildren());
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                onPressed: () {
                  if (context.locale == Locale('ar')) {
                    context.setLocale(Locale('en'));
                    Provider.of<SettingsController>(context, listen: false)
                        .changeCurrentAppLanguage();
                  } else {
                    context.setLocale(Locale('ar'));
                    Provider.of<SettingsController>(context, listen: false)
                        .changeCurrentAppLanguage();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.locale == Locale('ar')
                        ? Text("ترجم إلى الانجليزية")
                        : Text("Switch to Arabic language"),
                    Icon(Icons.language),
                  ],
                ),
                style:
                    ElevatedButton.styleFrom(backgroundColor: MyColors.color3),
              ),
            ),
            // MomComand(
            //   title: 'Timeline',
            //   subtitle: "Click to see your child timeline",
            //   icon: Icon(Icons.timeline),
            //   color: MyColors.color2,
            //   onPressed: (() {
            //     AppRouter.appRouter.goToWidget(Timeline());
            //   }),
            // ),
            //  Card(
            // color: MyColors.color3,
            // child: ListTile(
            //     leading: Icon(Icons.radio_button_checked), title: tmp())),
            MomComand(
              title: 'Log Out'.tr(),
              subtitle: "",
              icon: Icon(Icons.logout),
              color: MyColors.color4,
              onPressed: (() {
                AppRouter.appRouter.goToWidget(SignInPage1());
              }),
            )
          ]),
        )));
  }
}

class MomComand extends StatelessWidget {
  String title;
  String subtitle;
  Icon icon;
  Color color;
  final VoidCallback onPressed;
  MomComand({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon = const Icon(Icons.ads_click),
    required this.color,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        elevation: 1,
        child: ListTile(
            leading: Icon(Icons.radio_button_checked),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            subtitle: Text(
              subtitle,
            ),
            trailing: icon,
            onTap: onPressed));
  }
}
