// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import 'package:gp/Router/app_router.dart';
// import 'package:gp/UI/Landing_page/landing_page.dart';
// import 'package:gp/UI/Mom_UI/MomProfile.dart';
// import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
// import 'package:gp/core/API/children.dart';
// import 'package:gp/core/Colors/colors.dart';

// class childProfile extends StatelessWidget {
//   String childId;
//   childProfile({
//     Key? key,
//     required this.childId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           const StackContainer(),
//           Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   MomComand(
//                       title: "Mom's Profile".tr(),
//                       subtitle: "clik to see mom's details".tr(),
//                       color: MyColors.color4,
//                       onPressed: () {
//                         AppRouter.appRouter.goToWidget(MomProfile());
//                       }),
//                   CardItem(
//                     label: "Class".tr(),
//                     text: "ABC",
//                   ),
//                   CardItem(
//                     label: "Birth Of Date".tr(),
//                     text: "16/7/2019",
//                   ),
//                   CardItem(
//                     label: "Address".tr(),
//                     text: "Rafidia Street",
//                   ),
//                   CardItem(
//                     label: "Hobbies & Preferences".tr(),
//                     text: "masa.masri@gmail.com",
//                     islist: true,
//                     list: ["Pasta", "football", "Hide & Seek"],
//                   ),
//                   CardItem(
//                     label: "Food ALlergies from".tr(),
//                     text: "059484744",
//                     islist: true,
//                     list: ["Eggs", "milk"],
//                   ),
//                 ],
//               )),
//         ],
//       ),
//     ));
//   }
// }

// class TopBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.favorite, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

// List<String> s = [];

// class CardItem extends StatelessWidget {
//   String label;
//   String text;
//   bool islist;
//   List<String> list;
//   CardItem(
//       {Key? key,
//       required this.label,
//       required this.text,
//       this.islist = false,
//       this.list = const ["x"]})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16.0,
//           vertical: 21.0,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 islist
//                     ? Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: list
//                             .map((e) => RichText(
//                                     text: TextSpan(
//                                         text: '● ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: MyColors.color1,
//                                             fontSize: 16),
//                                         children: <TextSpan>[
//                                       TextSpan(text: e),
//                                     ])))
//                             .toList())
//                     : Text(
//                         text,
//                         style: TextStyle(
//                           color: Colors.grey[700],
//                           fontSize: 16.0,
//                         ),
//                       ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyCustomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height - 150);
//     path.lineTo(0, size.height);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class StackContainer extends StatelessWidget {
//   const StackContainer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 270.0,
//       child: Stack(
//         children: <Widget>[
//           Container(),
//           ClipPath(
//             clipper: MyCustomClipper(),
//             child: Container(
//               height: 300.0,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       "https://images.pexels.com/photos/1364073/pexels-photo-1364073.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: const Alignment(0, 1),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 60,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border:
//                             Border.all(width: 5, color: Colors.transparent)),
//                     child: ClipOval(
//                       child: Image.network(
//                         childrenList[2]["image"],
//                         height: 200,
//                         width: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 const Text(
//                   "Eleen Masri",
//                   style: TextStyle(
//                     fontSize: 21.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "child".tr(),
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           TopBar(),
//         ],
//       ),
//     );
//   }
// }
