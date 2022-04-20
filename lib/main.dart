import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_g_d_3/overlay_controller.dart';
import 'package:flame_g_d_3/dialog/dialog_box.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'characters/george_component.dart';
import 'loaders/add_baked_goods.dart';
import 'loaders/load_friends.dart';
import 'loaders/load_obstacles.dart';
import 'my_game.dart';

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
