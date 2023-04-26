import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/date_widget.dart';

class AddMatrial extends StatelessWidget {
  const AddMatrial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Add Material'),
      body: Column(
        children: [
          ShowDate(),
        ],
      ),
    );
  }
}
