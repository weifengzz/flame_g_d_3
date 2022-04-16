import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ButtonController extends StatelessWidget {
  const ButtonController({Key? key, required this.game}) : super(key: key);
  final MyGame game;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => {FlameAudio.bgm.play('music.mp3')},
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
    );
  }
}
