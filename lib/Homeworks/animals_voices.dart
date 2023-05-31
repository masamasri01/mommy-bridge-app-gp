import 'package:flutter/material.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import './playSound.dart';

class AnimalsVoices extends StatelessWidget {
  final List<String> animals = [
    'cow',
    'cat',
    'dog',
    'bird',
    'lion',
    'tiger',
    'horse'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab(
        ('Click on animal to hear sound'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(animals.length, (index) {
          return InkWell(
            onTap: () {
              playSpecificSound("${animals[index]}V.mp3");
              //       print('Image $index was clicked!');
            },
            child: Card(
              child: Image.asset(
                "assets/images/animalsGame/${animals[index]}.png",
                fit: BoxFit.contain,
              ),
            ),
          );
        }),
      ),
    );
  }
}
