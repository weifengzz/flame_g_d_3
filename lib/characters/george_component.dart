import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GeorgeComponent extends SpriteAnimationComponent
    with GestureHitboxes, CollisionCallbacks {
  GeorgeComponent() {
    add(RectangleHitbox());
  }
}