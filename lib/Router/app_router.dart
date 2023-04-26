import 'package:flutter/material.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/UI/staff_functionalities/meals.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:easy_localization/easy_localization.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  showCustomDialoug(String title, String content) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () {
                    navigatorKey.currentState!.pop();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  showLoadingDialoug() {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ],
          ),
        );
      },
    );
  }

  hideDialoug() {
    navigatorKey.currentState!.pop();
  }

  goToWidgetAndReplace(Widget widget) {
    navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  goToWidget(Widget widget) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  TextEditingController controller = new TextEditingController();
  String announcement = '';
  showAddAnnouncement() {
    return showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: pinkText('Add Announcement'.tr())),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 0.0,
              vertical: 30.0,
            ),
            content: SizedBox(
              height: 225,
              width: 280,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          focusColor: MyColors.color4,
                          border: OutlineInputBorder(),
                          labelText: 'Add Announcement'.tr().tr(),
                          hintText: 'Enter text'.tr(),
                        ),
                        controller: controller,
                        maxLines: 5,
                        // onChanged: (v) {
                        //   setState(() {
                        //     announcement = v;
                        //   });
                        // },
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          elevatedButon(
                            text: 'Cancel'.tr(),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          elevatedButon(
                              text: ('Announce'.tr()),
                              onPressed: () {
                                // Navigator.pop(context);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  EditBirtDate() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Edit your  number').tr(),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  elevatedButon(text: 'Edit'.tr(), onPressed: () {})
                ],
              ),
            ),
          );
        });
  }
}
