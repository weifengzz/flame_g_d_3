import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/cupertino.dart';

/// 碰撞检测
class BakedGoodComponent extends SpriteComponent
    with GestureHitboxes, CollisionCallbacks, ChangeNotifier, HasGameRef<MyGame> {
  BakedGoodComponent() {
    debugMode = true;
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    gameRef.bakedGoodsInventory++;
    print(gameRef.bakedGoodsInventory.toString() + '个');
    gameRef.remove(this);
  }
}
