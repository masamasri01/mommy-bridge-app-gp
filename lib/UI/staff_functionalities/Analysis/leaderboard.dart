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
          name: 'Roya',
          image: 'Wael',
          index: 1,
          points: 30,
        ),
        ChildTileLeaderboard(
          name: 'Masa Masri',
          image: 'image',
          index: 1,
          points: 22,
        ),
        ChildTileLeaderboard(
          name: 'Rahaf Omar',
          image: 'image',
          index: 1,
          points: 10,
        )
      ],
    );
  }
}
