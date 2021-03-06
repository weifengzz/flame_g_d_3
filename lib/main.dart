import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';
import 'overlays/overlay_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: MyGame(),
          overlayBuilderMap: {
            'OverlayController': (BuildContext context, MyGame game) {
              return OverlayController(
                game: game,
              );
            },
          },
        ),
      ),
    ),
  );
}
