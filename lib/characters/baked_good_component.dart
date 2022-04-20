import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import '../my_game.dart';

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
    gameRef.overlays.notifyListeners();
    gameRef.yummy.start();
    gameRef.remove(this);
  }
}
