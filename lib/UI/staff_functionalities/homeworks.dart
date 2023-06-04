// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/Homeworks/QA/qa_ddg.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:gp/Homeworks/Seasons/drag_drop.dart';
import 'package:gp/Homeworks/animals_quiz.dart/animals_app.dart';
import 'package:gp/Homeworks/animals_voices.dart';
import 'package:gp/Homeworks/color_quiz/speech_to_text.dart';
import 'package:gp/Homeworks/matching2/dragdrop2.dart';
import 'package:gp/Homeworks/shapes_quiz/shapes_speech_app.dart';
import 'package:gp/Homeworks/tracing/drawing.dart';
import 'package:gp/Router/app_router.dart';
import 'package:gp/UI/staff_functionalities/widgets/quiz_grid.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';

class Homework extends StatelessWidget {
  bool edit;
  Homework({
    Key? key,
    this.edit = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ab('Quizzes & Games'.tr()),
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
                    title: 'Colors'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(ShapesApp());
                    },
                    title: 'Shapes'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(AnimalsApp());
                    },
                    title: 'Animals'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(DragAndDropGame());
                    },
                    title: 'Seasons'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(TracingGame());
                    },
                    title: 'Drawing'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(AnimalsVoices());
                    },
                    title: 'Animals voices'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(DragAndDropGame2());
                    },
                    title: 'Habitats'.tr(),
                    edit: edit),
                QuizGridTile(
                    onPressed: () {
                      AppRouter.appRouter.goToWidget(QA());
                    },
                    title: 'Q&A'.tr(),
                    edit: edit),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
