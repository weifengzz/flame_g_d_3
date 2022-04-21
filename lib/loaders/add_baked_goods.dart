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
        BakedGoodComponent applePie = BakedGoodComponent()
          ..position = Vector2(bakedGoods.x, bakedGoods.y)
          ..width = bakedGoods.width
          ..height = bakedGoods.height
          ..sprite = await game.loadSprite('apple_pie.png')
          ..debugMode = true;
        game.add(
          applePie,
        );
        game.componentList.add(applePie);
        break;
      case 'ChocoCake':
        BakedGoodComponent chocoCake = BakedGoodComponent()
          ..position = Vector2(bakedGoods.x, bakedGoods.y)
          ..width = bakedGoods.width
          ..height = bakedGoods.height
          ..sprite = await game.loadSprite('choco_cake.png')
          ..debugMode = true;
        game.add(
          chocoCake,
        );
        game.componentList.add(chocoCake);
        break;
      case 'Cookie':
        BakedGoodComponent cookie = BakedGoodComponent()
          ..position = Vector2(bakedGoods.x, bakedGoods.y)
          ..width = bakedGoods.width
          ..height = bakedGoods.height
          ..sprite = await game.loadSprite('cookies.png')
          ..debugMode = true;
        game.add(
          cookie,
        );
        game.componentList.add(cookie);
        break;
      case 'CheeseCake':
        BakedGoodComponent cheeseCake = BakedGoodComponent()
          ..position = Vector2(bakedGoods.x, bakedGoods.y)
          ..width = bakedGoods.width
          ..height = bakedGoods.height
          ..sprite = await game.loadSprite('cheesecake.png')
          ..debugMode = true;
        game.add(
          cheeseCake,
        );
        game.componentList.add(cheeseCake);
        break;
    }
  }
}
