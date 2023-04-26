// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gp/core/Colors/colors.dart';

class ClippedOvalImage extends StatelessWidget {
  String image;
  ClippedOvalImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        child: ClipOval(
          child: Image.network(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
