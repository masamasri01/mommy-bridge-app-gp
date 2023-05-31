import 'package:flutter/cupertino.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph.dart';
import 'dart:convert';
import 'dart:io';

import 'package:gp/practice%20db/config.dart';
import 'package:http/http.dart' as http;

class QuizProvider extends ChangeNotifier {
  Map<String, dynamic> color = {};
  bool rightAnswer = false;
  int yourPoints = 0;
  setCurrentColor(Map<String, dynamic> m) {
    color = m;
    notifyListeners();
  }

  setrightAnswer(bool b) {
    rightAnswer = b;
    notifyListeners();
  }

  incrementPoints() {
    yourPoints++;
  }

  decrementPoints() {
    yourPoints--;
  }

  /**********************Shapes Quiz****************** */
  Map<String, dynamic> shape = {};
  bool rightAnswerShape = false;

  setCurrentShape(Map<String, dynamic> m) {
    shape = m;
    notifyListeners();
  }

  setrightAnswerShape(bool b) {
    rightAnswerShape = b;
    notifyListeners();
  }
  /**********************  Animals Quiz****************** */

  Map<String, dynamic> animal = {};
  bool rightAnswerAnimal = false;

  setCurrentAnimal(Map<String, dynamic> m) {
    animal = m;
    notifyListeners();
  }

  setrightAnswerAnimal(bool b) {
    rightAnswerAnimal = b;
    notifyListeners();
  }

  /**********************  Animals Quiz****************** */
  int shapesPlayedTimes = 2;
  int colorsPlayedTimes = 10;

  int animalsPlayedTimes = 20;

  int seasonsPlayedTimes = 50;
  int voicesPlayedTimes = 6;
  getno() {
    return colorsPlayedTimes;
  }

  List<Map<String, dynamic>> mylist = [];
  fillListOfMaps() {
    mylist.add({"game": "colors", 'noTimes': colorsPlayedTimes});
    mylist.add({"game": "shapes", 'noTimes': shapesPlayedTimes});
    mylist.add({"game": "animals", 'noTimes': animalsPlayedTimes});
    mylist.add({"game": "seasons", 'noTimes': seasonsPlayedTimes});
    mylist.add({"game": "voices", 'noTimes': voicesPlayedTimes});
  }

  late List<BarChartModel> data;
  fillListOfChart() {
    data = mylist.map((e) {
      return BarChartModel.fromMap(e);
    }).toList();
  }

  getDataList() {
    fillListOfMaps();
    fillListOfChart();
    return data;
  }

  var childIdG;
  int? scoreG;
  setChildIdG(String s) async {
    childIdG = s;
    print("child id games=" + s);
    scoreG = await getScore();
    print("score games=" + scoreG.toString());
    notifyListeners();
  }

  Future<int> getScore() async {
    var childId = childIdG;
    final apiUrl = '$increment$childId/score';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final score = data['score'] as int;
        scoreG = score;
        notifyListeners();
        return score;
      } else {
        throw Exception('Failed to get score');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to get score');
    }
  }

  Future<void> incrementScore() async {
    var childId = childIdG;
    if (childId == null) {
      // Handle the case where childId is null
      return;
    }

    final apiUrl = '$increment$childId/increment-score';

    try {
      final response = await http.put(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Score incremented successfully
        final updatedChild = json.decode(response.body);
        scoreG = await getScore();

        print('Updated Child: $updatedChild');
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Error occurred while making the API request
      print('Error: $e');
    }
  }

  Future<void> decrementScore() async {
    var childId = childIdG;
    if (childId == null) {
      // Handle the case where childId is null
      return;
    }

    final apiUrl = '$increment$childId/decrement-score';

    try {
      final response = await http.put(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Score incremented successfully
        scoreG = await getScore();
        final updatedChild = json.decode(response.body);
        print('Updated Child: $updatedChild');
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Error occurred while making the API request
      print('Error: $e');
    }
  }
}
