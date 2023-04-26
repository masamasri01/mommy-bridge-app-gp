// import 'package:flutter/material.dart';
// import 'package:gp1/Colors/colors.dart';
// import 'package:gp1/UI/widgets/custom_appBar.dart';
// import 'package:gp1/UI/widgets/custum_button.dart';

// class Announcements extends StatelessWidget {


//   TextEditingController controller = TextEditingController();

//   String announcement = "vr";

//   @override
//   Widget build(BuildContext context) {
//     return
//      showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text('Add Expense'),
//                 insetPadding: const EdgeInsets.symmetric(
//                   horizontal: 0.0,
//                   vertical: 30.0,
//                 ),
//                 content: Padding(
//                   padding: const EdgeInsets.all(1.0),
//                   child: Form(
//                     child: Column(
//                       children: <Widget>[
//                         Positioned(
//                           child: InkResponse(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: CircleAvatar(
//                               child: Icon(Icons.close),
//                             ),
//                           ),
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             hintText: 'What did you spend on?',
//                           ),
//                           controller:
//                               Provider.of<ProviderClass>(context, listen: false)
//                                   .title,
//                         ),
//                         TextFormField(
//                           // decoration: InputDecoration(
//                           //   labelText: 'Description on your spending',
//                           // ),
//                           // controller:
                             
//                         ),
                       
//                         ElevatedButton(
//                           child: Text(
//                             "Add",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () async {
//                             // await Provider.of<ProviderClass>(context,
//                             //         listen: false)
//                             //     .insertExpense();
//                             // log('message');
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                               minimumSize: const Size.fromHeight(50)),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             });
//       }
// }
