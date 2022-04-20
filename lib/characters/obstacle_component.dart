import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/characters/george_component.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/cupertino.dart';

/// 碰撞检测
class ObstacleComponent extends PositionComponent
    with
        GestureHitboxes,
        CollisionCallbacks,
        ChangeNotifier,
        HasGameRef<MyGame> {
  ObstacleComponent({
    required this.game,
  }) {
    add(RectangleHitbox());
  }

  final MyGame game;

  bool _hasCollided = false;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is GeorgeComponent) {
      if (!_hasCollided) {
        game.collisionDirection = game.direction;
        _hasCollided = true;
        print('collision is ============${game.collisionDirection}');
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is GeorgeComponent) {
      game.collisionDirection = -1;
      _hasCollided = false;
    }
  }
}
