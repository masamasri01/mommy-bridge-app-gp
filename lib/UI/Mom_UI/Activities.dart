// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:gp/Providers/Mom_provider.dart';
import 'package:gp/UI/staff_functionalities/widgets/childtile_2.dart';
import 'package:gp/UI/widgets/custom_appBar.dart';
import 'package:gp/UI/widgets/date_widget.dart';
import 'package:gp/core/API/children.dart';
import 'package:gp/core/Texts/text.dart';
import 'package:gp/practice%20db/config.dart';

class ActivitiesFeed extends StatefulWidget {
  ActivitiesFeed({
    Key? key,
  }) : super(key: key);

  @override
  State<ActivitiesFeed> createState() => _ActivitiesFeedState();
}

class _ActivitiesFeedState extends State<ActivitiesFeed> {
  List<Meal> meals = [];
  List<Nap> naps = [];
  List<Accident> accidents = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String momId = Provider.of<MomProvider>(context, listen: false).momId ?? "";
    fetchMeals(momId);
    fetchNaps(momId).then((naps) {
      setState(() {
        this.naps = naps;
      });
    });
    fetchAcccidents(momId).then((accidents) {
      setState(() {
        this.accidents = accidents;
      });
    });
  }

  Future<void> fetchMeals(String momId) async {
    try {
      final response = await http.get(Uri.parse('$getmeals$momId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (mounted) {
          // Check if the widget is still mounted
          setState(() {
            meals = jsonData.map<Meal>((meal) {
              return Meal(
                mealName: meal['mealName'],
                mealTime: meal['mealTime'],
                mealType: meal['mealType'],
                amount: meal['amount'],
                childId: meal['childId'],
              );
            }).toList();
          });
        }
      } else {
        print('Failed to fetch meals. Status code: ${response.statusCode}');
      }
    } catch (error) {
      if (mounted) {
        // Check if the widget is still mounted
        print('Failed to fetch meals: $error');
      }
    }
  }

  Future<List<Nap>> fetchNaps(String momId) async {
    try {
      final response = await http.get(Uri.parse('$getNaps$momId'));
      print("object+$getNaps$momId");
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData.map<Nap>((nap) {
          return Nap(
            startTime: nap['startTime'],
            endTime: nap['endTime'],
            childId: nap['childId'],
          );
        }).toList();
      } else {
        print('Failed to fetch naps. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Failed to fetch naps: $error');
      return [];
    }
  }

  Future<List<Accident>> fetchAcccidents(String momId) async {
    try {
      final response = await http.get(Uri.parse('$getAccidents$momId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData.map<Accident>((nap) {
          return Accident(
              accidentType: nap['accidentType'],
              description: nap['description'],
              childId: nap['childId'],
              time: nap['createdAt']);
        }).toList();
      } else {
        print('Failed to fetch accidents. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Failed to fetch accidents: $error');
      return [];
    }
  }

  Future<String> getChildName(String childId) async {
    try {
      final response = await http.get(Uri.parse('$getChildData$childId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['fullName'];
      } else {
        return 'Unknown';
      }
    } catch (error) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    String momId = Provider.of<MomProvider>(context, listen: false).momId ?? "";

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 247, 247),
      appBar: ab_noleading('Activities'.tr()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(9, 5, 9, 0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Column(
              children: [
                ShowDate(),
                Container(
                  height: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      87 -
                      kBottomNavigationBarHeight,
                  child: ListView.builder(
                    itemCount: meals.length + naps.length + accidents.length,
                    itemBuilder: (context, index) {
                      if (index < meals.length) {
                        // Render meal
                        final meal = meals[index];
                        return FutureBuilder(
                          future: getChildName(meal.childId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text('Loading...'),
                                subtitle: Text('Loading...'),
                                trailing: Text('Loading...'),
                              );
                            } else if (snapshot.hasError) {
                              return ListTile(
                                title: Text('Error loading child name'),
                                subtitle: Text('Error loading child name'),
                                trailing: Text('Error loading child name'),
                              );
                            } else {
                              final childName = snapshot.data;
                              return MealPost(
                                name: childName!,
                                meal: meal.mealName,
                                time: meal.mealTime,
                                type: meal.mealType,
                                amount: meal.amount,
                              );
                            }
                          },
                        );
                      } else if (index < meals.length + naps.length) {
                        // Render nap
                        final napIndex = index - meals.length;
                        final nap = naps[napIndex];
                        return FutureBuilder(
                          future: getChildName(nap.childId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text('Loading...'),
                                subtitle: Text('Loading...'),
                                trailing: Text('Loading...'),
                              );
                            } else if (snapshot.hasError) {
                              return ListTile(
                                title: Text('Error loading child name'),
                                subtitle: Text('Error loading child name'),
                                trailing: Text('Error loading child name'),
                              );
                            } else {
                              final childName = snapshot.data;
                              return NapPost(
                                name: childName!,
                                startTime: nap.startTime,
                                endTime: nap.endTime,
                              );
                            }
                          },
                        );
                      } else {
                        final accidentIndex =
                            index - (meals.length + naps.length);
                        final acc = accidents[accidentIndex];
                        return FutureBuilder(
                          future: getChildName(acc.childId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return ListTile(
                                title: Text('Loading...'),
                                subtitle: Text('Loading...'),
                                trailing: Text('Loading...'),
                              );
                            } else if (snapshot.hasError) {
                              return ListTile(
                                title: Text('Error loading child name'),
                                subtitle: Text('Error loading child name'),
                                trailing: Text('Error loading child name'),
                              );
                            } else {
                              final childName = snapshot.data;
                              return AccidentPost(
                                name: childName!,
                                desc: acc.description,
                                type: acc.accidentType,
                                time: acc.time,
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class NapPost extends StatelessWidget {
  String name;
  String startTime;
  String endTime;
  NapPost({
    Key? key,
    required this.name,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(
                      Icons.bed,
                      size: 35,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Nap'.tr(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.purple,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Nap started at:'.tr()), grayText(startTime)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Nap Ended at:'.tr()), grayText(endTime)],
            ),
            const SizedBox(
              height: 8,
            ),
            ChildTile2(index: 0, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }

  Future<String> getChildName(String childId) async {
    try {
      final response = await http.get(Uri.parse('your-api-url/child/$childId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData[
            'fullName']; // Assuming the child's full name is included in the response
      } else {
        return 'Unknown'; // Return a default name if fetching the child's name fails
      }
    } catch (error) {
      return 'Unknown'; // Return a default name if an error occurs
    }
  }
}

class MealPost extends StatelessWidget {
  String name;
  String meal;
  String time;
  String type;
  int amount;
  MealPost({
    Key? key,
    required this.name,
    required this.meal,
    required this.time,
    required this.type,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.food_bank_outlined,
                          size: 35,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Meal'.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                grayText(time)
              ],
            ),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Meal name:'.tr()), navyText(meal)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Meal type:'.tr()), navyText(type)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navyText('amount:'.tr()),
                amount == 0
                    ? navyText('Full ●')
                    : amount == 1
                        ? navyText('Half ◑')
                        : amount == 2
                            ? navyText('Quarter ◔')
                            : navyText('Nothing O')
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            ChildTile2(index: 1, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }
}

class AccidentPost extends StatelessWidget {
  String name;
  String time;
  String type;
  String desc;
  AccidentPost({
    Key? key,
    required this.name,
    required this.time,
    required this.type,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a').format(DateTime.parse(time));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.car_crash,
                        size: 35,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Accident/Incident'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              grayText(formattedTime)
            ]),
            const Divider(
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [navyText('Accident type:'.tr()), navyText(type)],
            ),
            navyText(desc),
            ChildTile2(index: 2, name: name, image: [1], activities: true),
          ],
        ),
      ),
    );
  }
}

String getDateToday(DateTime today) {
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];

  var currentMon = today.month;
  String dateStr =
      "${today.day} ${months[currentMon - 1].toString().toUpperCase()}, ${today.year}";
  return dateStr;
}

class Meal {
  final String mealName;
  final String mealTime;
  final String mealType;
  final int amount;
  final String childId; // New field to hold child's name

  Meal({
    required this.mealName,
    required this.mealTime,
    required this.mealType,
    required this.amount,
    required this.childId,
  });
}

class Nap {
  final String startTime;
  final String endTime;
  final String childId;

  Nap({
    required this.startTime,
    required this.endTime,
    required this.childId,
  });
}

class Accident {
  final String accidentType;
  final String description;
  final String childId;
  final String time;
  Accident({
    required this.accidentType,
    required this.description,
    required this.childId,
    required this.time,
  });
}
