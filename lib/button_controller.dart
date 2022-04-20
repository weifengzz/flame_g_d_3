import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'my_game.dart';

class ButtonController extends StatelessWidget {
  const ButtonController({Key? key, required this.game}) : super(key: key);
  final MyGame game;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => {FlameAudio.bgm.play('music.mp3', volume: 0.1)},
              icon: const Icon(
                Icons.headset_mic_sharp,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () => {FlameAudio.bgm.stop()},
              icon: const Icon(
                Icons.heart_broken_rounded,
                color: Colors.red,
              ),
            ),
            Text(
              game.soundTrackName,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
        Padding(
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
        ),
      ],
    );
  }
}
