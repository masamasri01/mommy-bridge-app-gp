import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class MyNotification extends StatefulWidget {
  @override
  State<MyNotification> createState() => _MyNotification();
}

class _MyNotification extends State<MyNotification> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await FirebaseMessaging.instance.subscribeToTopic('myTopic');
                },
                child: Text('Subscribe To Topic')),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseMessaging.instance
                      .unsubscribeFromTopic('myTopic');
                },
                child: Text('un Subscribe To Topic')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
