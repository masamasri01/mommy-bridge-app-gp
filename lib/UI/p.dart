// import 'package:flutter/material.dart';

// class AddMedicine extends StatefulWidget {
//   @override
//   _AddMedicineState createState() => _AddMedicineState();
// }

// class _AddMedicineState extends State<AddMedicine> {
//   final timeController = TextEditingController();

//   Widget build(BuildContext context) {
//     String value = "";
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: size.width,
//               padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 13),
//               child: const Text(
//                 'Reminder',
//                 style: TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 14,
//                   color: Color(0xff000000),
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             Container(
//               width: size.width * 0.85,
//               height: 52,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6.0),
//                 color: const Color(0xffffffff),
//                 border: Border.all(width: 1.0, color: const Color(0xffdbe2ea)),
//                 boxShadow: [
//                   const BoxShadow(
//                     color: Color(0x0a2c2738),
//                     offset: Offset(0, 4),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 controller: timeController,
//                 readOnly: true,
//                 style: const TextStyle(
//                   fontFamily: 'Montserrat',
//                   fontSize: 12,
//                   color: Color(0xff000000),
//                   fontWeight: FontWeight.w500,
//                 ),
//                 decoration: InputDecoration(
//                   suffixIcon:
//                    IconButton(
//                     onPressed: () async {
//                       var time = await showTimePicker(
//                         builder: (BuildContext context, Widget child) {
                        
//                         },
//                         context: context,
//                         initialTime: TimeOfDay.now(),
//                       );
//                       print(time.format(context));
//                       timeController.text = time.format(context);
//                       // scheduleAlarm();
//                     },
//                     icon: const Icon(
//                       Icons.add_alert,
//                       color: Color(0xffd4d411),
//                     ),
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//                   border: InputBorder.none,
//                   hintText: "Add time(s) to eat your medicine",
//                   hintStyle: const TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 13,
//                     color: Color(0xffcbd0d6),
//                   ),
//                 ),
//                 onChanged: (text) {
//                   value = text;
//                   print(value);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

