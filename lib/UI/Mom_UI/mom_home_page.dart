// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gp/UI/Mom_UI/Activities.dart';
import 'package:gp/UI/Mom_UI/Feed.dart';
import 'package:gp/UI/Mom_UI/MomProfile.dart';
import 'package:gp/chat/chat_home_page.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class MomHomePage extends StatefulWidget {
  const MomHomePage({super.key});

  @override
  State<MomHomePage> createState() => _MomHomePage();
}

class _MomHomePage extends State<MomHomePage> {
  int _currentIndex = 0;
  final List<Widget> _views = [
    Feed(),
    ActivitiesFeed(),
    ChatHomePage(),
    MomProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //   drawer: drawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyColors.color4,
        unselectedItemColor: Colors.grey,
        //  showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.run_circle), label: 'Activities'.tr()),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'.tr()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'.tr())
        ],
      ),
    );
    // } else {
    //   return Scaffold(
    //     body: Center(
    //         child: CircularProgressIndicator(
    //       valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
    //   )),
    //   );
    // }
  }
}

class s1 extends StatelessWidget {
  const s1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('1111'),
    );
  }
}

class s3 extends StatelessWidget {
  s3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('2222'),
    );
  }
}

class s2 extends StatelessWidget {
  s2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class s4 extends StatelessWidget {
  s4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
