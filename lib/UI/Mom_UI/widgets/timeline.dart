import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gp/UI/widgets/cliped_image.dart';

TextStyle style = TextStyle(color: Colors.white);

class TimelineComponent extends StatelessWidget {
  const TimelineComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = new Random();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //drawer: Drawer(),
        appBar: AppBar(title: Text('Ativities Timeline'), actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Stack(
              children: [
                ClippedOvalImage(
                    image:
                        'https://th.bing.com/th/id/OIP.lj-saYNmygnkYcTl8n8z0QHaGZ?pid=ImgDet&rs=1'),
                new Positioned(
                  right: 0,
                  top: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                child: Image.network(
                    "https://th.bing.com/th/id/R.ea64ea973c0fc906187db168ee7adabb?rik=aVIFffxcH9mPyQ&pid=ImgRaw&r=0",
                    fit: BoxFit.fitWidth),
              ),
              Positioned(
                top: 40,
                left: 30,
                child: Row(children: <Widget>[
                  Text("8", style: style.copyWith(fontSize: 70.0)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Monday", style: style.copyWith(fontSize: 25.0)),
                        Text("February 2015".toUpperCase(),
                            style: style.copyWith(fontSize: 12.0)),
                      ],
                    ),
                  ),
                ]),
              ),
              Positioned(
                bottom: -20,
                right: 15,
                child: FloatingActionButton(
                  onPressed: null,
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: null,
                    iconSize: 40.0,
                  ),
                  backgroundColor: Colors.red,
                ),
              )
            ],
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: false,
                itemCount: listOfEvents.length,
                itemBuilder: (context, i) {
                  return Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Row(
                          children: [
                            SizedBox(width: size.width * 0.1),
                            SizedBox(
                              child: Text(listOfEvents[i].time),
                              width: size.width * 0.2,
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listOfEvents[i].eventName),
                                  Text(
                                    listOfEvents[i].description,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 50,
                        child: new Container(
                          height: size.height * 0.7,
                          width: 1.0,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: new BoxDecoration(
                              color: listOfColors[random.nextInt(3)],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ]));
  }
}

class Events {
  final String time;
  final String eventName;
  final String description;

  Events(
      {required this.time, required this.eventName, required this.description});
}

final List<Events> listOfEvents = [
  Events(time: "5pm", eventName: "New Icon", description: "Mobile App"),
  Events(
      time: "3 - 4pm", eventName: "Design Stand Up", description: "Hangouts"),
  Events(time: "12pm", eventName: "Lunch Break", description: "Main Room"),
  Events(
      time: "9 - 11am",
      eventName: "Finish Home Screen",
      description: "Web App"),
  Events(
      time: "9 - 11am",
      eventName: "Finish Home Screen",
      description: "Web App"),
  Events(
      time: "9 - 11am",
      eventName: "Finish Home Screen",
      description: "Web App"),
  Events(
      time: "9 - 11am",
      eventName: "Finish Home Screen",
      description: "Web App"),
];
final List<Color> listOfColors = [
  Constants.kPurpleColor,
  Constants.kGreenColor,
  Constants.kRedColor
];

class Constants {
  static const kPurpleColor = Color(0xFFB97DFE);
  static const kRedColor = Color(0xFFFE4067);
  static const kGreenColor = Color(0xFFADE9E3);
}
