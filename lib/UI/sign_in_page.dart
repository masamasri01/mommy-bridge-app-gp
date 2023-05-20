import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/Mom_UI/mom_home_page.dart';
import 'package:gp/UI/staff_functionalities/staff_home_page.dart/staff_landing.dart';
import 'package:gp/config.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supercharged/supercharged.dart';
import 'package:http/http.dart' as http;

class SignInPage1 extends StatefulWidget {
  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  final TextEditingController _emailController = TextEditingController();
  late SharedPreferences prefs;
  String? errorMessage = null;
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  var token1;
  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  var savedJsonRes;
  Future<bool> loginUserToMongo(String n) async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      var reqBody = {
        "email": _emailController.text,
        "password": _passwordController.text
      };
      http.Response response;
      if (n == "m") {
        response = await http.post(Uri.parse(loginMom),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody));
      } else {
        response = await http.post(Uri.parse(loginTeacher),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody));
      }

      var jsonResponse = jsonDecode(response.body);
      savedJsonRes = jsonResponse;
      // print('status is-----' + jsonResponse['status'].toString());
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        //    print(jsonResponse["name"] + "---------name----------");
        //   prefs.setString('token', myToken);
        token1 = myToken;
        //  print('token is-----' + token1);
        return true;
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Dashboard2(token: myToken)));
      } else {
        log('Something went wrong');
        setState(() {
          errorMessage = "please inter proper data";
        });

        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  'Sign In'.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 189, 185, 185)))),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        errorText: errorMessage,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    obscureText: true,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        errorText: errorMessage,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          1.5,
                          Text(
                            "login".tr(),
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FadeAnimation(
                              2,
                              InkWell(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Teacher".tr(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Provider.of<TeacherProvider>(context,
                                          listen: false)
                                      .isMom = false;
                                  Provider.of<TeacherProvider>(context,
                                          listen: false)
                                      .isTeacher = true;
                                  // AppRouter.appRouter.goToWidget(StaffLanding());
                                  _signInWithEmailAndPassword('t');
                                },
                              )),
                          FadeAnimation(
                              2,
                              InkWell(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: Text(
                                      "Mom".tr(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Provider.of<TeacherProvider>(context,
                                          listen: false)
                                      .isMom = true;
                                  Provider.of<TeacherProvider>(context,
                                          listen: false)
                                      .isTeacher = false;
                                  _signInWithEmailAndPassword('m');
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // Sign in with email and password using Firebase Authentication
  void _signInWithEmailAndPassword(String n) async {
    try {
      // Call Firebase Authentication sign in method

      bool userExistsInMongo = await loginUserToMongo(n);
      print("ntoken is______________" + token1);
      if (userExistsInMongo) {
        if (n == 't') {
          Provider.of<TeacherProvider>(context, listen: false)
              .setSavedJsonRes(savedJsonRes);
          Provider.of<TeacherProvider>(context, listen: false)
              .setUserToken(token1);
        } else {
          Provider.of<MomProvider>(context, listen: false)
              .setSavedJsonRes(savedJsonRes);
          Provider.of<MomProvider>(context, listen: false).setUserToken(token1);
        }

        final userExistsInFirebase = await isUserExists(_emailController.text);
        if (userExistsInFirebase) {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
        } else {
          // user does not exist in FB so create it then login

          signUpWithFirebase(_emailController.text, _passwordController.text);
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );
        }
        // Navigate to home screen on successful sign in
        AppRouter.appRouter.goToWidgetAndReplace(n == 'm'
            ? MomHomePage(token: token1)
            : StaffLanding(token: token1));
      } else
        setState(() {
          errorMessage = "please inter proper data";
        });
    } on FirebaseAuthException catch (e) {
      // Display error message on failed sign in
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<bool> isUserExists(String email) async {
    final signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return signInMethods.isNotEmpty;
  }

  Future<UserCredential> signUpWithFirebase(
      String email, String password) async {
    final auth = FirebaseAuth.instance;
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0))
      ..add(AniProps.translateY, (-30.0).tweenTo(0.0).curved(Curves.easeOut));

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(0, animation.get(AniProps.translateY)),
          child: child,
        ),
      ),
    );
  }
}

enum AniProps { opacity, translateY }

// class AuthGate extends StatelessWidget {
//   const AuthGate({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SignInPage1();
//           } else
//             return SignInPage1();
//         });
//   }
// }
