import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'characters/george_component.dart';
import 'dialog/dialog_box.dart';
import 'loaders/add_baked_goods.dart';
import 'loaders/load_friends.dart';
import 'loaders/load_obstacles.dart';

class MyGame extends FlameGame
    with TapDetector, HasCollisionDetection, FPSCounter, ChangeNotifier {
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

  late TiledComponent homeMap;

  List<Component> componentList = [];

  // late SpriteComponent background;

  final double characterSize = 100.0;
  final double characterSpeed = 100.0;

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

  // collisionDirection is -1, there is no collision
  int collisionDirection = -1;

  int friendNumber = 0;
  int maxFriends = 0;
  int sceneNumber = 1;

  int bakedGoodsInventory = 0;

  String dialogMessage = 'hello my name is song ximing...';

  bool showDialog = true;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    homeMap = await TiledComponent.load(
      'map.tmx',
      Vector2.all(16.0),
    );

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    add(homeMap);

    addBakedGoods(homeMap, this);

    yummy = await AudioPool.create('yummy.mp3');
    applause = await AudioPool.create('applause.mp3');

    loadFriends(homeMap, this);

    loadObstacles(homeMap, this);
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

    overlays.add('OverlayController');
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

  void newScene() async {
    String mapFile = 'map1.tmx';
    remove(homeMap);
    bakedGoodsInventory = 0;
    friendNumber = 0;
    maxFriends = 0;
    direction = 0;
    FlameAudio.bgm.stop();
    for (Component item in componentList) {
      bool isMounted = item.isMounted;
      if (isMounted) {
        remove(item);
      }
    }
    showDialog = false;
    remove(george);
    if (sceneNumber == 2) {}
    george = GeorgeComponent(game: this)
      ..position = Vector2(300, 200)
      ..size = Vector2.all(characterSize)
      ..debugMode = true;
    homeMap = await TiledComponent.load(
      mapFile,
      Vector2.all(16.0),
    );
    add(homeMap);
    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;
    // addBakedGoods(homeMap, this);
    // loadFriends(homeMap, this);
    // loadObstacles(homeMap, this);
    add(george);
    camera.followComponent(
      george,
      worldBounds: Rect.fromLTWH(0, 0, mapWidth, mapHeight),
    );
  }
}
