import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:provider/provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/UI/widgets/custum_button.dart';
import 'package:http/http.dart' as http;

TextEditingController editC = TextEditingController();

class MomProfile extends StatefulWidget {
  @override
  State<MomProfile> createState() => _MomProfile();
}

class _MomProfile extends State<MomProfile> {
  var res;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MomProvider>(context, listen: false).setMomData();
    res = Provider.of<MomProvider>(context, listen: false).momData;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MomProvider>(builder: (context, prov, x) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(
              Name: prov.momData['name'],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    CardItem(
                      label: "Name".tr(),
                      text: prov.momData['name'],
                      edit: false,
                    ),
                    CardItem(
                      label: "Email".tr(),
                      text: prov.momData['email'],
                      idx: 2,
                      edit: false,
                    ),
                    CardItem(
                      label: "Phone".tr(),
                      text: prov.momData['phone'],
                      editText: 'Edit your phone number',
                      onPressed: () {
                        prov.updatePhone();
                        prov.setMomData();
                        Navigator.pop(context);
                      },
                    ),
                    CardItem(
                      label: "Job".tr(),
                      text: prov.momData['job'],
                      editText: 'Edit your Job',
                      onPressed: () {
                        prov.updateJob();
                        prov.setMomData();
                        Navigator.pop(context);
                      },
                    ),
                    CardItem(
                      label: "Address".tr(),
                      text: prov.momData['address'],
                      editText: 'Edit your Address',
                      onPressed: () {
                        prov.updateAddress();
                        prov.setMomData();
                        Navigator.pop(context);
                      },
                    ),
                    CardItem(
                      label: "Relationship Status".tr(),
                      text: prov.momData['relationship'],
                      editText: 'Edit your Relationship Status',
                      onPressed: () {
                        prov.updateRelation();
                        prov.setMomData();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          ],
        ),
      ));
    });
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  String label;
  String text;
  bool edit;
  int idx;
  VoidCallback? onPressed;
  String? editText;
  CardItem(
      {Key? key,
      required this.label,
      required this.text,
      this.edit = true,
      this.idx = 0,
      this.editText,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 21.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            this.edit
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(editText!).tr(),
                              content: SizedBox(
                                height: 150,
                                child: Column(
                                  children: [
                                    TextField(
                                      keyboardType: (label == "Phone")
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      controller: editC,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    elevatedButon(
                                        text: 'Edit'.tr(),
                                        onPressed: onPressed!)
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 30.0,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 150);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class StackContainer extends StatelessWidget {
  String Name;
  StackContainer({
    Key? key,
    required this.Name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/core/images/momback.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 5, color: Colors.transparent)),
                    child: ClipOval(
                      child: Image.network(
                        "https://images.pexels.com/photos/5212317/pexels-photo-5212317.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  Name,
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Mom".tr(),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
