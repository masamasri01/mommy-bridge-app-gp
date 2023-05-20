// import 'package:flutter/material.dart';
// import 'package:gp/Providers/Mom_provider.dart';
// import 'package:gp/UI/Mom_UI/widgets/allergies_widget.dart';
// import 'package:gp/UI/widgets/custom_appBar.dart';
// import 'package:gp/UI/widgets/custum_button.dart';
// import 'package:gp/UI/widgets/dropdownbutton.dart';
// import 'package:gp/UI/widgets/text_area.dart';
// import 'package:gp/core/API/children.dart';
// import 'package:gp/core/API/my_children.dart';
// import 'package:gp/core/Texts/text.dart';
// import 'package:provider/provider.dart';
// import 'package:easy_localization/easy_localization.dart';

// class Preferences extends StatelessWidget {
//   const Preferences({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ab('Preferences and Hobbies'.tr()),
//       body: Consumer<MomProvider>(builder: (context, provider, x) {
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               MyTextField(
//                   label: 'Preferences'.tr(),
//                   hint: 'Add a hobby or preference'.tr(),
//                   controller: provider.preferenceNameController),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   navyText('Assign it for:'.tr()),
//                   myDropdownButton(
//                       val: mychildrenList[0]['name'],
//                       itemss: mychildrenList
//                           .map((e) => e['name'].toString())
//                           .toList()),
//                 ],
//               ),
//               Divider(),
//               Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 150),
//                   child: elevatedButon(text: 'Add', onPressed: () {})),
//               Divider(),
//               SingleChildScrollView(
//                 child: Column(
//                     children: childrenList.map((e) {
//                   return AllergiesWidget(
//                       Allergies: e['hobbies'], childName: e['name']);
//                 }).toList()),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
