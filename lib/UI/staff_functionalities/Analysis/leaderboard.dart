import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gp/Providers/Teacher_provider.dart';
import 'package:gp/UI/staff_functionalities/widgets/leaderboard_childtile.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatelessWidget {
  //const Leaderboard({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> childrenList =
        Provider.of<TeacherProvider>(context, listen: false).myChildrenList;

    // Sort the childrenList based on points (highest to lowest)
    childrenList.sort((a, b) => b['score'].compareTo(a['score']));

    return ListView.builder(
      itemCount: childrenList.length,
      itemBuilder: (BuildContext context, int index) {
        // Get the data for each child from the childrenList
        String name = childrenList[index]['fullName'];

        // Decode the JSON-encoded image data
        var imageData = Uint8List.fromList(
            (childrenList[index]['image']['data']).cast<int>());

        int points = childrenList[index]['score'];

        return ChildTileLeaderboard(
          name: name,
          image: imageData,
          index: 1,
          points: points,
        );
      },
    );
  }
}
