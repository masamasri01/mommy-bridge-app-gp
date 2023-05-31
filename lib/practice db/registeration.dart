// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'config.dart';

// class RegisterationForm extends StatefulWidget {
//   RegisterationForm({super.key});

//   @override
//   State<RegisterationForm> createState() => _RegisterationFormState();
// }

// class _RegisterationFormState extends State<RegisterationForm> {
//   TextEditingController emailController = TextEditingController();

//   TextEditingController passwordController = TextEditingController();

//   bool _isNotValidate = false;

//   void registerUser() async {
//     if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
//       var regBody = {
//         "email": emailController.text,
//         "password": passwordController.text
//       };
//       var response = await http.post(Uri.parse(registeration),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode(regBody));
//       var jsonResponse = jsonDecode(response.body);
//       print(jsonResponse['status']);
//       if (jsonResponse['status']) {
//         //  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
//       } else {
//         print("SomeThing Went Wrong");
//       }
//     } else {
//       setState(() {
//         _isNotValidate = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: emailController,
//           ),
//           TextField(
//             controller: passwordController,
//           ),
//           ElevatedButton(onPressed: registerUser, child: Text('submit'))
//         ],
//       ),
//     );
//   }
// }
