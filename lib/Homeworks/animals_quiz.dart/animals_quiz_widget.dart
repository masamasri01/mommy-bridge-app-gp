// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gp/Homeworks/playSound.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:provider/provider.dart';

class AnimalsQuiz extends StatefulWidget {
  String recognizedWord;

  AnimalsQuiz({
    Key? key,
    required this.recognizedWord,
  }) : super(key: key);
  @override
  AnimalsQuizState createState() => AnimalsQuizState();
}

class AnimalsQuizState extends State<AnimalsQuiz> {
  final _animals = [
    {'name': 'bird', 'audioFile': 'bird.mp3'},
    {'name': 'turtle', 'audioFile': 'turtle.mp3'},
    {'name': 'horse', 'audioFile': 'horse.mp3'},
    {'name': 'cat', 'audioFile': 'cat.mp3'},
    {'name': 'dog', 'audioFile': 'dog.mp3'},
    {'name': 'fish', 'audioFile': 'fish.mp3'},
  ];
  Random _random = new Random();
  Map<String, dynamic> _animal = {};
  String _question = "What Animal is this?";
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _animal = _animals[_random.nextInt(_animals.length)];
    Provider.of<QuizProvider>(context, listen: false).setCurrentAnimal(_animal);
    playSoundWhatAnimalIsThis();
  }

  void generateQuestion() {
    setState(() {
      _animal = _animals[_random.nextInt(_animals.length)];
      Provider.of<QuizProvider>(context, listen: false)
          .setCurrentAnimal(_animal);
      _question = "What Animal is this?";
      _showAnswer = false;

      playSoundWhatAnimalIsThis();
    });
  }

  Future<void> _playSound() async {
    final player = AudioCache();
    player.play(_animal['audioFile']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _question,
              style: TextStyle(fontSize: 24.0),
            ),
            Container(
                height: 210,
                child: Image.asset(
                    'assets/images/animalsGame/${_animal['name']}.png')),
            SizedBox(height: 2.0),
            if (_showAnswer)
              ElevatedButton(
                child: Text('Play Again'),
                onPressed: () {
                  setState(() {
                    _showAnswer = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x4B9AA7FF)),
              ),
            SizedBox(height: 2.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Cheat Answer'),
                    onPressed: () {
                      setState(() {
                        _playSound();

                        //  _showAnswer = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9AA7FF)),
                  ),
                  SizedBox(height: 2.0),
                  ElevatedButton(
                    child: Text('Next Question=>'),
                    onPressed: () => generateQuestion(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9AA7FF)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

isTrueAnswerr(String recognized, String animal) {
  if (recognized.toLowerCase().contains(animal.toLowerCase()) ||
      toArablic(animal).contains(recognized)) return true;

  int diffs = 0;
  for (int i = 0; i < animal.length; i++) {
    if (recognized[i] != animal[i]) {
      diffs++;
    }
    if (diffs > 2) {
      return false;
    }
  }
  return diffs > 2;
}

toArablic(animal) {
  switch (animal) {
    case 'bird':
      return "  عصفوره عصفور";
    case 'turtle':
      return "سلحفاه";
    case 'horse':
      return "حصان";
    case 'cat':
      return "قطه قط";
    case 'dog':
      return "كلب";
    case 'fish':
      return "سمكة سمك";
  }
}
