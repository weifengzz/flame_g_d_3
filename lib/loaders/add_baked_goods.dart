import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup, TiledObject;
import '../characters/baked_good_component.dart';
import '../my_game.dart';

/// 添加食物
void addBakedGoods(TiledComponent homeMap, MyGame game) async {
  final ObjectGroup bakedGoodsGroup =
      homeMap.tileMap.getLayer('BakedGoods') as ObjectGroup;
  for (TiledObject bakedGoods in bakedGoodsGroup.objects) {
    switch (bakedGoods.type) {
      case 'ApplePie':
        game.add(
          BakedGoodComponent()
            ..position = Vector2(bakedGoods.x, bakedGoods.y)
            ..width = bakedGoods.width
            ..height = bakedGoods.height
            ..sprite = await game.loadSprite('apple_pie.png')
            ..debugMode = true,
        );
        break;
      case 'ChocoCake':
        game.add(
          BakedGoodComponent()
            ..position = Vector2(bakedGoods.x, bakedGoods.y)
            ..width = bakedGoods.width
            ..height = bakedGoods.height
            ..sprite = await game.loadSprite('choco_cake.png')
            ..debugMode = true,
        );
        break;
      case 'Cookie':
        game.add(
          BakedGoodComponent()
            ..position = Vector2(bakedGoods.x, bakedGoods.y)
            ..width = bakedGoods.width
            ..height = bakedGoods.height
            ..sprite = await game.loadSprite('cookies.png')
            ..debugMode = true,
        );
        break;
      case 'CheeseCake':
        game.add(
          BakedGoodComponent()
            ..position = Vector2(bakedGoods.x, bakedGoods.y)
            ..width = bakedGoods.width
            ..height = bakedGoods.height
            ..sprite = await game.loadSprite('cheesecake.png')
            ..debugMode = true,
        );
        break;
    }
  }
}
