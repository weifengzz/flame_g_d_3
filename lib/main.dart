import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_g_d_3/button_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: MyGame(),
          overlayBuilderMap: {
            'ButtonController': (BuildContext context, MyGame game) {
              return const ButtonController();
            },
          },
        ),
      ),
    ),
  );
}

class MyGame extends FlameGame with TapDetector {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;

  late SpriteAnimationComponent george;

  late SpriteComponent background;

  final double animationSpeed = .1;
  final double characterSize = 100.0;
  final double characterSpeed = 100.0;

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    Sprite backgroundSprite = await loadSprite('background.png');

    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = backgroundSprite.originalSize;

    add(background);

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

    george = SpriteAnimationComponent()
      ..animation = downAnimation
      ..position = Vector2(characterSize, characterSize)
      ..size = Vector2.all(100);

    add(george);

    camera.followComponent(
      george,
      worldBounds: Rect.fromLTRB(
        0,
        0,
        background.size.x,
        background.size.y,
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
        if (george.y < background.size.y - george.height) {
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
        if (george.x < background.size.x - george.width) {
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
