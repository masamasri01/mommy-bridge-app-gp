import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/Homeworks/Seasons/drag_drop.dart';
import 'package:gp/Homeworks/animals_quiz.dart/animals_app.dart';
import 'package:gp/Homeworks/color_quiz/speech_to_text.dart';
import 'package:gp/Homeworks/shapes_quiz/shapes_speech_app.dart';
import 'package:gp/Homeworks/tracing/drawing.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/staff_functionalities/widgets/quiz_grid.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';

class Homework extends StatelessWidget {
  const Homework({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Homeworks'),
      // drawer: drawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: GridView.count(crossAxisCount: 3, children: [
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(SpeechSampleApp());
                    },
                    title: 'Colors'),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(ShapesApp());
                    },
                    title: 'Shapes'),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(AnimalsApp());
                    },
                    title: 'Animals'),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(DragAndDropGame());
                    },
                    title: 'Seasons'),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(TracingGame());
                    },
                    title: 'Drawing'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
