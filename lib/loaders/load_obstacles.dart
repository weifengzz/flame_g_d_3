import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup;
import '../characters/obstacle_component.dart';
import '../my_game.dart';

void loadObstacles(TiledComponent homeMap, MyGame game) {
  final ObjectGroup obstacleGroup =
      homeMap.tileMap.getLayer('Obstacles') as ObjectGroup;
  for (var obstacleBox in obstacleGroup.objects) {
    game.add(
      ObstacleComponent(game: game)
        ..position = Vector2(obstacleBox.x, obstacleBox.y)
        ..width = obstacleBox.width
        ..height = obstacleBox.height
        ..debugMode = true,
    );
  }
}
