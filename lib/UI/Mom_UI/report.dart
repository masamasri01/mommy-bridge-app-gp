import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/Providers/App_provider.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartModel, String>> series = [
      charts.Series(
        id: "financial",
        data: Provider.of<AppProvider>(context).getDataList(),
        domainFn: (BarChartModel series, _) => series.game,
        measureFn: (BarChartModel series, _) => series.playedTimes,
        colorFn: (BarChartModel series, _) => series.color,
      ),
    ];

    return Scaffold(
      appBar: ab('Report'),
      backgroundColor: Colors.white,
      body: Consumer<AppProvider>(builder: (context, prov, x) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Child Name:',
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 53, 53), fontSize: 16),
                  ),
                  Text('Yara Jabr',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Report of month Month:',
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 53, 53), fontSize: 16),
                  ),
                  Text('February',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Color.fromARGB(255, 201, 199, 199),
                height: 50,
              ),
              boldPinkText("َConsumed Quantityies of Meals"),
              Row(
                children: [Text("Repeated times")],
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
              Text('Quantity'),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Color.fromARGB(255, 201, 199, 199),
                height: 50,
              ),
              boldPinkText("َNaps"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Hours of naps slept:',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text('21 hours and 20 minuites',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 77, 73, 73))),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Average slept Hours of naps per day:',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text('1 hours and 12 minuites',
                        style: TextStyle(
                            color: Color.fromARGB(255, 77, 73, 73),
                            fontSize: 16)),
                  ],
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Color.fromARGB(255, 201, 199, 199),
                height: 50,
              ),
              boldPinkText("Attendance"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Number of days child attended this month:',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text('23 days',
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 73, 73))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Number of days child was absent this month:',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    Text('6 days',
                        style:
                            TextStyle(color: Color.fromARGB(255, 77, 73, 73))),
                  ],
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2,
                color: Color.fromARGB(255, 201, 199, 199),
                height: 50,
              ),
              Card(
                child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "Teacher Notes:",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                            "During the nursery sessions, I have noticed that Yara tends to be shy and less communicative compared to other children. It is essential to encourage and support their development in this area. Additionally, their eating habits could benefit from improvement. ")
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
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
