import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh2/games/UghGame.dart';

class EmberPlayer2 extends SpriteAnimationComponent
    with HasGameRef<UghGame>,KeyboardHandler {

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