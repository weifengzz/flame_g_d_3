import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/cupertino.dart';

/// 碰撞检测
class FriendComponent extends PositionComponent
    with GestureHitboxes, CollisionCallbacks, ChangeNotifier, HasGameRef<MyGame> {
  FriendComponent({
    required this.game,
  }) {
    add(RectangleHitbox());
  }

  final MyGame game;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print('我遇见一个好朋友');
    game.friendNumber++;
    game.overlays.notifyListeners();
    gameRef.remove(this);
    gameRef.applause.start();
    super.onCollision(intersectionPoints, other);
  }
}
