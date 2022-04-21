import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flame_g_d_3/my_game.dart';
import 'package:flutter/material.dart';

class DialogOverlay extends StatelessWidget {
  const DialogOverlay({
    Key? key,
    required this.game,
  }) : super(key: key);

  final MyGame game;

  @override
  Widget build(BuildContext context) {
    return game.showDialog
        ? Container(
            color: const Color.fromARGB(167, 218, 218, 218),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  game.dialogMessage,
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'vt323',
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
              onFinished: () {
                game.showDialog = false;
                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                game.overlays.notifyListeners();
              },
            ),
          )
        : Container();
  }
}
