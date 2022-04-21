import 'package:flame_g_d_3/overlays/dialog_overlay.dart';
import 'package:flame_g_d_3/overlays/score_overlay.dart';
import 'package:flutter/material.dart';

import '../my_game.dart';
import 'audio_overlay.dart';

class OverlayController extends StatelessWidget {
  const OverlayController({Key? key, required this.game}) : super(key: key);
  final MyGame game;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AudioOverlay(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ScoreOverlay(game: game),
            ),
            Expanded(
              flex: 2,
              child: DialogOverlay(game: game,),
            ),
          ],
        ),
      ],
    );
  }
}
