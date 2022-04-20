import 'package:flutter/material.dart';

import '../my_game.dart';

class ScoreOverlay extends StatelessWidget {
  const ScoreOverlay({Key? key, required this.game}) : super(key: key);

  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/friend.png',
            scale: .7,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            game.friendNumber.toString(),
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 50.0,
          ),
          Image.asset(
            'assets/images/cookies.png',
            scale: .7,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            game.bakedGoodsInventory.toString(),
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
