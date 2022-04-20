import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame_g_d_3/my_game.dart';
import 'package:flutter/material.dart';

class DialogOverly extends StatelessWidget {
  const DialogOverly({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          game.dialogMessage,
          textStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      isRepeatingAnimation: false,
      onFinished: () => {
        print('object')
      },
    );
  }
}
