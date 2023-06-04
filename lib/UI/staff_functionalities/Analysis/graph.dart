// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:gp/Providers/QuizProvider.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:provider/provider.dart';

class Analysis extends StatefulWidget {
  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: Provider.of<QuizProvider>(context).getDataList(),
        domainFn: (BarChartModel series, _) => series.game,
        measureFn: (BarChartModel series, _) => series.playedTimes,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      //  appBar: ab('Analysis of Played Games'),
      backgroundColor: Colors.white,
      body: Consumer<QuizProvider>(builder: (context, prov, x) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Text("played times".tr())],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: SizedBox(
                height: 320,
                child: Expanded(
                  child: charts.BarChart(
                    series,
                    animate: true,
                  ),
                ),
              ),
            ),
            Text('Games'.tr()),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
              color: Color.fromARGB(255, 201, 199, 199),
              height: 50,
            ),
            Container()
          ],
        );
      }),
    );
  }
}

class BarChartModel {
  String game;
  int playedTimes;
  charts.Color color = charts.ColorUtil.fromDartColor(MyColors.color3);

  BarChartModel({
    required this.game,
    required this.playedTimes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'game': game,
      'noTimes': playedTimes,
    };
  }

  factory BarChartModel.fromMap(Map<String, dynamic> map) {
    return BarChartModel(
      game: map['game'] as String,
      playedTimes: map['noTimes'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BarChartModel.fromJson(String source) =>
      BarChartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
