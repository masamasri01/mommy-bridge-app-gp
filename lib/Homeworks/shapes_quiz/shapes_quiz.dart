// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gp/Homeworks/playSound.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:provider/provider.dart';

class ShapesQuiz extends StatefulWidget {
  String recognizedWord;

  ShapesQuiz({
    Key? key,
    required this.recognizedWord,
  }) : super(key: key);
  @override
  ShapesQuizState createState() => ShapesQuizState();
}

class ShapesQuizState extends State<ShapesQuiz> {
  final _shapes = [
    {'name': 'Rectangle', 'audioFile': 'rectangle.mp3'},
    {'name': 'Circle', 'audioFile': 'circle.mp3'},
    {'name': 'Square', 'audioFile': 'square.mp3'},
    {'name': 'Triangle', 'audioFile': 'triangle.mp3'},
    {'name': 'Oval', 'audioFile': 'oval.mp3'},
  ];
  Random _random = new Random();
  Map<String, dynamic> _shape = {};
  String _question = "What Shape is this?";
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    _shape = _shapes[_random.nextInt(_shapes.length)];
    Provider.of<QuizProvider>(context, listen: false).setCurrentShape(_shape);

    playSoundWhatShapeIsThis();
  }

  void generateQuestion() {
    setState(() {
      _shape = _shapes[_random.nextInt(_shapes.length)];
      Provider.of<QuizProvider>(context, listen: false).setCurrentShape(_shape);
      _question = "What Shape is this?";
      _showAnswer = false;

      playSoundWhatShapeIsThis();
    });
  }

  Future<void> _playSound() async {
    final player = AudioCache();
    player.play(_shape['audioFile']);
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
                child: _shape['name'] == 'Oval'
                    ? Oval()
                    : _shape['name'] == 'Circle'
                        ? circle()
                        : _shape['name'] == 'Triangle'
                            ? Container(
                                width: 200,
                                height: 200,
                                child: CustomPaint(
                                  size: Size(200, 200),
                                  painter: TrianglePainter(),
                                ),
                              )
                            : _shape['name'] == 'Rectangle'
                                ? Rectangle()
                                : _shape['name'] == 'Square'
                                    ? Square()
                                    : Square()),
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

isTrueAnswer(String recognized, String color) {
  if (recognized.toLowerCase().contains(color.toLowerCase()) ||
      recognized == getArabic(color)) return true;

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

getArabic(color) {
  switch (color) {
    case "red":
      return 'احمر';
    case "Triangle":
      return "مثلث";
    case "Rectangle":
      return "مستطيل";
    case "Circle":
      return "دائره";
    case "Square":
      return "مربع";
    case "Oval":
      return "بيضاوي";
  }
}

circle() {
  return Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
  );
}

Square() {
  return Container(
    width: 200,
    height: 200,
    color: Colors.pink,
  );
}

Rectangle() {
  return Container(
    width: 300,
    height: 170,
    color: Colors.green,
  );
}

Oval() {
  return Container(
    width: 300,
    height: 200,
    decoration: BoxDecoration(
      color: Colors.yellow,
      borderRadius: BorderRadius.circular(100),
    ),
  );
}

// Custom painter for triangle shape
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.orange);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}
