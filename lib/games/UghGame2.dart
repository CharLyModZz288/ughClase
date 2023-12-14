import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh2/elementos/Corazon.dart';
import 'package:ugh2/elementos/Gota.dart';

import '../elementos/Estrella.dart';
import '../players/EmberPlayer.dart';
import '../players/EmberPlayer2.dart';

class UghGame2 extends Forge2DGame with HasKeyboardHandlerComponents{

  //final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayer _player;
  late EmberPlayer2 _player2;
  late EmberPlayer2Body _playerBody2;
  late TiledComponent mapComponent;


  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'reading.png',
      'tilemap1_32.png'
    ]);
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent=await TiledComponent.load('mapa1.tmx', Vector2.all(32));
    world.add(mapComponent);

    ObjectGroup? estrellas=mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for(final estrella in estrellas!.objects){
      Estrella spriteStar = Estrella(position: Vector2(estrella.x,estrella.y),
      size: Vector2.all(64));
      add(spriteStar);
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x,gota.y),
          size: Vector2.all(64));
      add(spriteGota);
    }
    ObjectGroup? corazones=mapComponent.tileMap.getLayer<ObjectGroup>("corazones");

    for(final corazon in corazones!.objects){
      Corazon spriteCorazon = Corazon(position: Vector2(corazon.x,corazon.y),
          size: Vector2.all(64));
      add(spriteCorazon);
    }

    _player = EmberPlayer(position: Vector2(128, canvasSize.y - 150),

    );

    _player2 = EmberPlayer2(position: Vector2(328, canvasSize.y - 150),

    );

    world.add(_player);
    //world.add(_player2);

    _playerBody2=EmberPlayer2Body(initialPosition: Vector2(328, canvasSize.y - 150));
    world.add(_playerBody2);
    //world.add(EmberPlayer2Body(initialPosition: Vector2(30,30)));

  }
  
  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Color.fromRGBO(102, 178, 255, 1.0);
  }

}