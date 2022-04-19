import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_g_d_3/button_controller.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup;
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

import 'characters/friend_component.dart';
import 'characters/george_component.dart';
import 'loaders/add_baked_goods.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: MyGame(),
          overlayBuilderMap: {
            'ButtonController': (BuildContext context, MyGame game) {
              return ButtonController(
                game: game,
              );
            },
          },
        ),
      ),
    ),
  );
}

class MyGame extends FlameGame
    with TapDetector, HasCollisionDetection, FPSCounter {
  static final fpsTextPaint = TextPaint(
    style: const TextStyle(color: Color(0xFFFFFFFF)),
  );

  @override
  // ignore: overridden_fields
  bool debugMode = true;

  late GeorgeComponent george;

  late double mapWidth;
  late double mapHeight;

  // late SpriteComponent background;

  final double characterSize = 100.0;
  final double characterSpeed = 100.0;

  final String soundTrackName = '女驸马';

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

  int friendNumber = 0;

  int bakedGoodsInventory = 0;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    final homeMap = await TiledComponent.load(
      'map.tmx',
      Vector2.all(16.0),
    );

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    add(homeMap);

    addBakedGoods(homeMap, this);

    final ObjectGroup friendGroup =
        homeMap.tileMap.getLayer('Friends') as ObjectGroup;
    for (var friendBox in friendGroup.objects) {
      add(
        FriendComponent(game: this)
          ..position = Vector2(friendBox.x, friendBox.y)
          ..width = friendBox.width
          ..height = friendBox.height
          ..debugMode = true,
      );
    }

    // Sprite backgroundSprite = await loadSprite('background.png');

    // background = SpriteComponent()
    //   ..sprite = backgroundSprite
    //   ..size = backgroundSprite.originalSize;

    // add(background);

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');
    // FlameAudio.bgm.play('music.mp3');

    george = GeorgeComponent(game: this)
      ..position = Vector2(characterSize, characterSize)
      ..debugMode = true
      ..size = Vector2.all(100);

    add(george);

    camera.followComponent(
      george,
      worldBounds: Rect.fromLTRB(
        0,
        0,
        mapWidth,
        mapHeight,
      ),
    );

    overlays.add('ButtonController');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (debugMode) {
      fpsTextPaint.render(canvas, fps(120).toString(), Vector2(0, 50));
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
  }

}
