import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';


class AudioOverlay extends StatelessWidget {
  const AudioOverlay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => {FlameAudio.bgm.play('music.mp3', volume: 0.3)},
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
      ],
    );
  }
}
