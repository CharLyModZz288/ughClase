import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh2/games/UghGame.dart';

import '../elementos/Estrella.dart';
import '../games/UghGame2.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<UghGame2>,KeyboardHandler,CollisionCallbacks {

  int horizontalDirection = 0;
  int verticalDirection = 0;
  //LEYES DE NEWTON v=a*t
  //LEYES DE NEWTON d=v*t
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;
  late CircleHitbox hitbox;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2(100,160), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('reading.png'),
      SpriteAnimationData.sequenced(
        amount: 15,
        amountPerRow: 5,
        textureSize: Vector2(60,88),
        stepTime: 0.12,
      ),
    );
    hitbox=CircleHitbox();
    add(hitbox);
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Estrella){
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    horizontalDirection=0;
    verticalDirection=0;
    if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      horizontalDirection=1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      horizontalDirection=-1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
      verticalDirection=-1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      verticalDirection=1;
    }

    else{
      horizontalDirection=0;
    }

    return true;
  }


  @override
  void update(double dt) {
    // TODO: implement update
    velocidad.x = horizontalDirection * aceleracion; //v=a*t
    position += velocidad * dt; //d=v*t
    velocidad.y = verticalDirection * aceleracion; //v=a*t
    position += velocidad * dt; //d=v*t
    super.update(dt);
  }


}