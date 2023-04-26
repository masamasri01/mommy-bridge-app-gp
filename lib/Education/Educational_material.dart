import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';

class EducationalMaterial extends StatelessWidget {
  const EducationalMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Resources'),
    );
  }
}
