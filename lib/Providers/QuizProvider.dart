import 'package:flutter/cupertino.dart';
import 'package:gp/UI/staff_functionalities/Analysis/graph.dart';

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
}
