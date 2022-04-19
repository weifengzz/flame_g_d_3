import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import '../main.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks, HasGameRef {
  GeorgeComponent({required this.game}) {
    add(
      RectangleHitbox.relative(
        Vector2.all(1),
        position: Vector2.all(48 / 2),
        parentSize: Vector2.all(48),
      ),
    );
  }

  final MyGame game;

  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;

  final double animationSpeed = .1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('george2.png'),
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

    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    switch (game.direction) {
      case 0:
        animation = idleAnimation;
        break;
      case 1:
        if (y < game.mapHeight - height) {
          y += dt * game.characterSpeed;
        }
        animation = downAnimation;
        break;
      case 2:
        animation = leftAnimation;
        if (x > 0) {
          x -= dt * game.characterSpeed;
        }
        break;
      case 3:
        animation = upAnimation;
        if (y > 0) {
          y -= dt * game.characterSpeed;
        }
        break;
      case 4:
        animation = rightAnimation;
        if (x < game.mapWidth - width) {
          x += dt * game.characterSpeed;
        }
        break;
      default:
        break;
    }
    super.update(dt);
  }
}
