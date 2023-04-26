import 'package:flutter/material.dart';
import 'package:gp/Homeworks/color_quiz/speech_to_text.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:provider/provider.dart';

class DragAndDropGame extends StatefulWidget {
  @override
  _DragAndDropGameState createState() => _DragAndDropGameState();
}

class _DragAndDropGameState extends State<DragAndDropGame> {
  List<ItemModel> items = [];
  List<ItemModel> items2 = [];

  int score = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(
          icon: Icons.coffee,
          name: "Coffee",
          value: "Coffee",
          question: "winter.jpg",
          answer: "winterans.jpg"),
      ItemModel(
          icon: Icons.catching_pokemon,
          name: "dog",
          value: "dog",
          question: "summer.png",
          answer: "summerans.png"),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    int score = Provider.of<QuizProvider>(context, listen: false).yourPoints;

    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: ab('Matching Game'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Text.rich(TextSpan(children: [
            //   TextSpan(text: "Score: "),
            //   TextSpan(
            //       text: "$score",
            //       style: TextStyle(
            //         color: Colors.green,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 30.0,
            //       ))
            // ])),
            yourPoints(),
            if (!gameOver)
              Row(
                children: <Widget>[
                  Column(
                      children: items.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(3.0),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: Column(
                          children: [
                            // Icon(
                            //   item.icon,
                            //   color: Colors.grey,
                            //   size: 50.0,
                            // ),
                            Container(
                                height: 160,
                                width: 160,
                                child: Image.asset(
                                    "assets/images/dragDrop/${item.question}"))
                          ],
                        ),
                        feedback: Column(
                          children: [
                            // Icon(
                            //   item.icon,
                            //   color: Colors.teal,
                            //   size: 50,
                            // ),
                            Container(
                                height: 160,
                                width: 160,
                                child: Image.asset(
                                    "assets/images/dragDrop/${item.question}"))
                          ],
                        ),
                        child: Column(
                          children: [
                            // Icon(
                            //   item.icon,
                            //   color: Colors.teal,
                            //   size: 50,
                            // ),
                            Container(
                              height: 160,
                              width: 160,
                              child: Image.asset(
                                  "assets/images/dragDrop/${item.question}"),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 6,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 2, // set the width of the divider
                    height: 350, // set the height of the divider
                    color: Colors.green, // set the color of the divider
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Column(
                      children: items2.map((item) {
                    return DragTarget<ItemModel>(
                      onAccept: (receivedItem) {
                        if (item.value == receivedItem.value) {
                          setState(() {
                            items.remove(receivedItem);
                            items2.remove(item);
                            Provider.of<QuizProvider>(context, listen: false)
                                .incrementPoints();
                            item.accepting = false;
                          });
                        } else {
                          setState(() {
                            Provider.of<QuizProvider>(context, listen: false)
                                .decrementPoints();
                            item.accepting = false;
                          });
                        }
                      },
                      onLeave: (receivedItem) {
                        setState(() {
                          item.accepting = false;
                        });
                      },
                      onWillAccept: (receivedItem) {
                        setState(() {
                          item.accepting = true;
                        });
                        return true;
                      },
                      builder: (context, acceptedItems, rejectedItem) => Column(
                        children: [
                          // Container(
                          //   color: item.accepting ? Colors.red : Colors.teal,
                          //   height: 50,
                          //   width: 100,
                          //   alignment: Alignment.center,
                          //   margin: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     item.name,
                          //     style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 18.0),
                          //   ),
                          // ),
                          Container(
                              height: 160,
                              width: 160,
                              child: Image.asset(
                                  "assets/images/dragDrop/${item.answer}")),
                          Divider(
                            color: Colors.grey,
                            thickness: 6,
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            if (gameOver)
              Text(
                "Good Job ",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            if (gameOver)
              Center(
                child: ElevatedButton(
                  // textColor: Colors.white,
                  //  color: Colors.pink,
                  child: Text("New Game"),
                  onPressed: () {
                    initGame();
                    setState(() {});
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final IconData icon;
  final String question;
  final String answer;
  bool accepting;

  ItemModel(
      {required this.name,
      required this.value,
      required this.icon,
      required this.answer,
      required this.question,
      this.accepting = false});
}
