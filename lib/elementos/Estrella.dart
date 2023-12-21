

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ugh2/games/UghGame.dart';

import '../games/UghGame2.dart';

class Estrella extends SpriteComponent with HasGameRef<UghGame2>,CollisionCallbacks{


  Estrella({required super.position,required super.size});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite=Sprite(game.images.fromCache('star.png'));
    anchor=Anchor.center;
    add(RectangleHitbox()..collisionType=CollisionType.passive);
    return super.onLoad();
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

    super.onCollision(intersectionPoints, other);
  }
}