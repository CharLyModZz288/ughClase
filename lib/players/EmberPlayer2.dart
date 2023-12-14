import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh2/games/UghGame.dart';

import '../games/UghGame2.dart';


class EmberPlayer2Body extends BodyComponent{

  EmberPlayer2Body({Vector2? initialPosition})
      : super(
    fixtureDefs: [
      FixtureDef(
        CircleShape()..radius = 0.1,
        restitution: 0.8,
        friction: 0.4,
      ),
    ],
    bodyDef: BodyDef(
      //gravityOverride: Vector2(0,-9.8),
      angularDamping: 0.8,
      position: initialPosition ?? Vector2.zero(),
      type: BodyType.dynamic,
    ),
  );

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad
    add(EmberPlayer2(position: Vector2(0,0)));
    return super.onLoad();
  }
}

class EmberPlayer2 extends SpriteAnimationComponent
    with HasGameRef<UghGame2>,KeyboardHandler {

  int horizontalDirection = 0;
  int verticalDirection = 0;
  //LEYES DE NEWTON v=a*t
  //LEYES DE NEWTON d=v*t
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;

  EmberPlayer2({
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
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent
    horizontalDirection=0;
    verticalDirection=0;
    if(keysPressed.contains(LogicalKeyboardKey.numpad6)){
      horizontalDirection=1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.numpad4)){
      horizontalDirection=-1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.numpad8)){
      verticalDirection=-1;
    }

    else if(keysPressed.contains(LogicalKeyboardKey.numpad2)){
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