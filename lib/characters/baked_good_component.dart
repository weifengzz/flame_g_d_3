import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_g_d_3/main.dart';
import 'package:flutter/cupertino.dart';

/// 碰撞检测
class BakedGoodComponent extends SpriteComponent
    with GestureHitboxes, CollisionCallbacks, ChangeNotifier, HasGameRef<MyGame> {
  BakedGoodComponent() {
    debugMode = true;
  }
}
