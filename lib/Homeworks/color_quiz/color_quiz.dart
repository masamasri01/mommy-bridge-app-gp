// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gp/Homeworks/playSound.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:provider/provider.dart';

class ColorsQuiz extends StatefulWidget {
  String recognizedWord;

  ColorsQuiz({
    Key? key,
    required this.recognizedWord,
  }) : super(key: key);
  @override
  ColorsQuizState createState() => ColorsQuizState();
}

class ColorsQuizState extends State<ColorsQuiz> {
  final _colors = [
    {'name': 'Red', 'audioFile': 'red.mp3'},
    {'name': 'Blue', 'audioFile': 'blue.mp3'},
    {'name': 'Green', 'audioFile': 'green.mp3'},
    {'name': 'Yellow', 'audioFile': 'yellow.mp3'},
    {'name': 'Purple', 'audioFile': 'purple.mp3'},
    {'name': 'Orange', 'audioFile': 'orange.mp3'},
  ];
  Random _random = new Random();
  Map<String, dynamic> _color = {};
  String _question = "What color is this?";
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _color = _colors[_random.nextInt(_colors.length)];
    Provider.of<QuizProvider>(context, listen: false).setCurrentColor(_color);

    playSoundWhatColorIsThis();
  }

  void generateQuestion() {
    setState(() {
      _color = _colors[_random.nextInt(_colors.length)];
      Provider.of<QuizProvider>(context, listen: false).setCurrentColor(_color);
      _question = "What color is this?";
      _showAnswer = false;

      playSoundWhatColorIsThis();
    });
  }

  Future<void> _playSound() async {
    final player = AudioCache();
    player.play(_color['audioFile']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _color['name'] == 'Red'
            ? Colors.red
            : _color['name'] == 'Blue'
                ? Colors.blue
                : _color['name'] == 'Green'
                    ? Colors.green
                    : _color['name'] == 'Yellow'
                        ? Colors.yellow
                        : _color['name'] == 'Purple'
                            ? Colors.purple
                            : _color['name'] == 'Orange'
                                ? Colors.orange
                                : Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _question,
              style: TextStyle(fontSize: 24.0),
            ),
            GestureDetector(
              onTap: _playSound,
              child: Container(
                  height: 230.0,
                  width: 400.0,
                  child: Image.asset(
                      'assets/images/colorsGame/${_color['name'].toLowerCase()}.png')),
            ),
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
            Row(
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
          ],
        ),
      ),
    );
  }
}

isTrueAnswer(String recognized, String color) {
  if (recognized.toLowerCase().contains(color.toLowerCase()) ||
      recognized == toArablic(color)) return true;

  int diffs = 0;
  for (int i = 0; i < color.length; i++) {
    if (recognized[i] != color[i]) {
      diffs++;
    }
    if (diffs > 2) {
      return false;
    }
  }
  return diffs > 2;
}

toArablic(color) {
  switch (color) {
    case 'Blue':
      return "ازرق";
    case 'Green':
      return "اخضر";
    case 'Red':
      return "احمر";
    case 'Yellow':
      return "اصفر";
    case 'Purple':
      return "بنفسجي";
    case 'Orange':
      return "برتقالي";
  }
}
