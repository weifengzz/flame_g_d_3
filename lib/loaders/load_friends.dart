import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup;
import '../characters/friend_component.dart';
import '../my_game.dart';

void loadFriends(TiledComponent homeMap, MyGame game) {
  final ObjectGroup friendGroup =
      homeMap.tileMap.getLayer('Friends') as ObjectGroup;
  for (var friendBox in friendGroup.objects) {
    FriendComponent friendComponent = FriendComponent(game: game)
      ..position = Vector2(friendBox.x, friendBox.y)
      ..width = friendBox.width
      ..height = friendBox.height
      ..debugMode = true;
    game.maxFriends++;
    game.add(friendComponent);
  }
}
