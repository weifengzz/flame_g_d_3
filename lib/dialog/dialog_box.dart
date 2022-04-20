import 'package:flame/components.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/material.dart';

class DialogBox extends TextBoxComponent {
  DialogBox({
    required String text,
    required this.game,
  }) : super(
          text: text,
          position: game.size,
          boxConfig: TextBoxConfig(
            dismissDelay: 5.0,
            maxWidth: game.size.x * .5,
            timePerChar: 0.1,
          ),
        ) {
    anchor = Anchor.bottomRight;
  }

  final MyGame game;

  @override
  void drawBackground(Canvas c) {
    Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(
      rect,
      Paint()..color = Colors.red,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (finished) {
      game.remove(this);
    }
  }
}
