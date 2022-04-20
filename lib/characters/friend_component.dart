import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/dialog/dialog_box.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/cupertino.dart';

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
    if (game.bakedGoodsInventory > 0) {
      String message = 'thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,thank you very much,';
      game.dialogBox = DialogBox(text: message, game: game);
      game.add(game.dialogBox);
      game.friendNumber++;
      game.bakedGoodsInventory -= 1;
      game.overlays.notifyListeners();
      gameRef.applause.start();
      gameRef.remove(this);
    } else {
      String message = 'great to meet you!great to meet you!great to meet you!great to meet you!great to meet you!';
      game.dialogBox = DialogBox(text: message, game: game);
      game.add(game.dialogBox);
      gameRef.remove(this);
    }

    super.onCollision(intersectionPoints, other);
  }
}
