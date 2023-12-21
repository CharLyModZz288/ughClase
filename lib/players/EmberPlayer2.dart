import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugh2/games/UghGame.dart';

import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';

class EmberPlayer2 extends SpriteAnimationComponent
    with HasGameRef<UghGame>,KeyboardHandler {
  static const  int I_PLAYER_SUBZERO=0;
  static const  int I_PLAYER_SCORPIO=1;
  static const  int I_PLAYER_TANYA=2;

  late int iTipo=-1;

  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  int horizontalDirection = 0;
  int verticalDirection = 0;
  //LEYES DE NEWTON v=a*t
  //LEYES DE NEWTON d=v*t
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;

  EmberPlayer2({
    required super.position,required super.size,
  }) : super(anchor: Anchor.center);

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
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox();
    hitbox.paint=defaultPaint;
    hitbox.isSolid=true;
    add(hitbox);
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    if(other is Gota){
      this.removeFromParent();
    }
    else if(other is Estrella){
      other.removeFromParent();
    }
    //super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    //super.onCollisionStart(intersectionPoints, other);
    hitbox.paint.color = _collisionStartColor;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    /*super.onCollisionEnd(other);
    if (!isColliding) {
      hitbox.paint.color = _defaultColor;
    }*/
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