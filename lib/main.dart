import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
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

  // 0=idle, 1=down, 2=left, 3=up, 4=right
  int direction = 0;

  @override
  Future<void>? onLoad() async {
    super.onLoad();

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
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (direction) {
      case 0:
        george.animation = idleAnimation;
        break;
      case 1:
        george.animation = downAnimation;
        george.y += 1;
        break;
      case 2:
        george.animation = leftAnimation;
        george.x -= 1;
        break;
      case 3:
        george.animation = upAnimation;
        george.y -= 1;
        break;
      case 4:
        george.animation = rightAnimation;
        george.x += 1;
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
}
