import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_g_d_3/button_controller.dart';
import 'package:flame_g_d_3/dialog/dialog_box.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'characters/george_component.dart';
import 'loaders/add_baked_goods.dart';
import 'loaders/load_friends.dart';
import 'loaders/load_obstacles.dart';

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

  late AudioPool yummy;
  late AudioPool applause;
  late DialogBox dialogBox;

  // late SpriteComponent background;

  final double characterSize = 100.0;
  final double characterSpeed = 100.0;

  final String soundTrackName = '魔王音';

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

  // collisionDirection is -1, there is no collision
  int collisionDirection = -1;

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

    yummy = await AudioPool.create('yummy.mp3');
    applause = await AudioPool.create('applause.mp3');

    dialogBox = DialogBox(text: 'hello My name is song ximing', game: this);

    add(dialogBox);

    loadFriends(homeMap, this);
  
    loadObstacles(homeMap, this);
    // Sprite backgroundSprite = await loadSprite('background.png');

    // background = SpriteComponent()
    //   ..sprite = backgroundSprite
    //   ..size = backgroundSprite.originalSize;

    // add(background);

    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.flac');
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
