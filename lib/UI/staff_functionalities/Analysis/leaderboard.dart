import 'package:flutter/cupertino.dart';
import 'package:gp/UI/staff_functionalities/widgets/leaderboard_childtile.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ChildTileLeaderboard(
          name: 'Fuad Abdullah',
          image: 'Wael',
          index: 1,
          points: 30,
        ),
        ChildTileLeaderboard(
          name: 'Ahmad Omar',
          image: 'image',
          index: 1,
          points: 22,
        ),
        ChildTileLeaderboard(
          name: 'Yara Jabr',
          image: 'image',
          index: 1,
          points: 10,
        ),
        ChildTileLeaderboard(
          name: 'Huda Ameer',
          image: 'image',
          index: 1,
          points: 10,
        ),
        ChildTileLeaderboard(
          name: 'Zeina Masri',
          image: 'image',
          index: 1,
          points: 10,
        ),
        ChildTileLeaderboard(
          name: 'Moen Alaa',
          image: 'image',
          index: 1,
          points: 10,
        )
      ],
    );
  }
}
