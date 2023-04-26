import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/UI/Landing_page/landing_page.dart';
import 'package:gp/UI/sign_in_page.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/main.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'Stay Connected App',
              body: '',
              image: Center(
                  child: Image.asset('lib/core/images/intro1.jpeg',
                      fit: BoxFit.cover, height: double.infinity)),
              decoration: const PageDecoration(
                  contentMargin: EdgeInsets.all(11.0),
                  titleTextStyle: TextStyle(
                      backgroundColor: Color.fromARGB(255, 225, 186, 184),
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Schyler'),
                  fullScreen: true)),
          PageViewModel(
            title: 'Feel safe',
            body: 'Have the feeling of being near your kids & be comfortable',
            image: Center(
                child: Image.asset('lib/core/images/intro2.jpeg',
                    fit: BoxFit.cover, height: double.infinity)),
            decoration: const PageDecoration(
                titleTextStyle: TextStyle(
                    backgroundColor: Color.fromARGB(32, 0, 0, 0),
                    fontSize: 70,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Schyler'),
                bodyTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Color.fromARGB(255, 225, 186, 184),
                ),
                imagePadding: EdgeInsets.all(0),
                fullScreen: true),
          ),
          PageViewModel(
              title: '',
              body: '',
              image: Center(
                  child: Image.asset('lib/core/images/intro3.jpeg',
                      fit: BoxFit.cover, height: double.infinity)),
              decoration: const PageDecoration(
                  titleTextStyle:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  bodyTextStyle: TextStyle(fontSize: 20),
                  imagePadding: EdgeInsets.all(24),
                  pageColor: Colors.white,
                  fullScreen: true)),
          PageViewModel(
              body: ' ',
              title: 'Start your journey',
              footer: ButtonWidget(
                text: 'click to start!',
                onClicked: () => goToHome(context),
                key: null,
              ),
              image: Center(
                  child: Image.asset('lib/core/images/intro4.jpeg',
                      fit: BoxFit.cover, height: double.infinity)),
              decoration: const PageDecoration(
                  bodyTextStyle: TextStyle(fontSize: 20),
                  titleTextStyle: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  contentMargin:
                      EdgeInsets.only(top: 130, left: 0, right: 00, bottom: 0),
                  // imagePadding: EdgeInsets.all(24),
                  pageColor: Color.fromARGB(26, 0, 0, 0),
                  fullScreen: true)),
        ],
        done: const Text(
          'Start',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Trajan Pro',
              fontWeight: FontWeight.w900),
        ),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: const Text(
          'Skip',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Trajan Pro',
              fontWeight: FontWeight.w900),
        ),
        onSkip: () => goToHome(context),
        next: const Icon(
          Icons.arrow_forward,
          color: Color.fromARGB(255, 154, 167, 255),
        ),
        dotsDecorator: const DotsDecorator(
          color: Color(0xFFBDBDBD),
          activeColor: Color.fromARGB(255, 154, 167, 255),
          size: Size(10, 10),
          activeSize: Size(22, 15),
          activeShape: CircleBorder(),
        ),
        globalBackgroundColor: const Color.fromARGB(255, 154, 167, 255),
        dotsFlex: 0,
        animationDuration: 800,
      ),
    );
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SignInPage1()),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 154, 167, 255),
          shape: const StadiumBorder(),
        ),
        //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
}
