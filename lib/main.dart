import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_g_d_3/button_controller.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup;
import 'package:flutter/material.dart';
import 'package:tiled/tiled.dart';

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

class MyGame extends FlameGame with TapDetector, HasCollisionDetection {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;

  late GeorgeComponent george;

  late double mapWidth;
  late double mapHeight;

  // late SpriteComponent background;

  final double animationSpeed = .1;
  final double characterSize = 100.0;
  final double characterSpeed = 100.0;

  final String soundTrackName = '女驸马';

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

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

    final ObjectGroup friendGroup = homeMap.tileMap.getLayer('Friends') as ObjectGroup;
    for (var friendBox in friendGroup.objects) {
      add(
        FriendComponent()
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

    final spriteSheet = SpriteSheet(
      image: await images.load('george2.png'),
      srcSize: Vector2(48.0, 48.0),
    );

    downAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: animationSpeed,
      to: 4,
    );

    leftAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: animationSpeed,
      to: 4,
    );

    upAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: animationSpeed,
      to: 4,
    );

    rightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: animationSpeed,
      to: 4,
    );

    idleAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: animationSpeed,
      to: 1,
    );

    george = GeorgeComponent()
      ..animation = downAnimation
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
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case 0:
        george.animation = idleAnimation;
        break;
      case 1:
        if (george.y < mapHeight - george.height) {
          george.y += dt * characterSpeed;
        }
        george.animation = downAnimation;
        break;
      case 2:
        george.animation = leftAnimation;
        if (george.x > 0) {
          george.x -= dt * characterSpeed;
        }
        break;
      case 3:
        george.animation = upAnimation;
        if (george.y > 0) {
          george.y -= dt * characterSpeed;
        }
        break;
      case 4:
        george.animation = rightAnimation;
        if (george.x < mapWidth - george.width) {
          george.x += dt * characterSpeed;
        }
        break;
      default:
        break;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    direction += 1;
    if (direction > 4) {
      direction = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

/// 碰撞检测
class FriendComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks {
  FriendComponent() {
    add(RectangleHitbox());
  }
}

class GeorgeComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks {
  GeorgeComponent() {
    add(RectangleHitbox());
  }
}
