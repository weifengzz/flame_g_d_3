import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/characters/george_component.dart';
import 'package:flutter/cupertino.dart';

import '../my_game.dart';

/// 碰撞检测
class FriendComponent extends PositionComponent
    with
        GestureHitboxes,
        CollisionCallbacks,
        ChangeNotifier,
        HasGameRef<MyGame> {
  FriendComponent({
    required this.game,
  }) {
    add(RectangleHitbox());
  }

  final MyGame game;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GeorgeComponent) {
      if (game.bakedGoodsInventory > 0) {
        game.dialogMessage =
            'thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,';
        game.friendNumber++;
        game.bakedGoodsInventory -= 1;
        gameRef.applause.start();
      } else {
        game.dialogMessage =
            'great to meet you!great to meet you!great to meet you!great to meet you!great to meet you!';
      }
      game.showDialog = true;
      game.overlays.notifyListeners();
      gameRef.remove(this);
    }

    super.onCollision(intersectionPoints, other);
  }
}
