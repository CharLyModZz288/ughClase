import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh2/bodies/TierraBody.dart';
import 'package:ugh2/elementos/Corazon.dart';
import 'package:ugh2/elementos/Gota.dart';

import '../configs/config.dart';
import '../elementos/Estrella.dart';
import '../players/EmberPlayer.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';

import '../players/EmberPlayer2.dart';


class UghGame extends Forge2DGame with
    HasKeyboardHandlerComponents,HasCollisionDetection{

  //final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player;
  late EmberPlayer2 _player2;

  late TiledComponent mapComponent;

  double wScale=1.0,hScale=1.0;

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
    //cameraComponent = CameraComponent(world: world);
    /*cameraComponent = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    );*/
    wScale=size.x/gameWidth;
    hScale=size.y/gameHeight;

    


    /*final cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 900,
      height: 600,
    );*/
    // Everything in this tutorial assumes that the position
    // of the `CameraComponent`s viewfinder (where the camera is looking)
    // is in the top left corner, that's why we set the anchor here.
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent=await TiledComponent.load('mapa1.tmx', Vector2(32*wScale,32*hScale));
    world.add(mapComponent);

    ObjectGroup? estrellas=mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for(final estrella in estrellas!.objects){
      Estrella spriteStar = Estrella(position: Vector2(estrella.x*wScale,estrella.y*hScale),
      size: Vector2(64*wScale,64*hScale));
      add(spriteStar);
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      Gota spriteGota = Gota(position: Vector2(gota.x*wScale,gota.y*hScale),
          size: Vector2(64*wScale,64*hScale));
      add(spriteGota);
    }
    ObjectGroup? corazones=mapComponent.tileMap.getLayer<ObjectGroup>("corazones");

    for(final corazon in corazones!.objects){
      Corazon spriteCorazon = Corazon(position: Vector2(corazon.x*wScale,corazon.y*hScale),
          size: Vector2(64*wScale,64*hScale));
      add(spriteCorazon);
    }

    ObjectGroup? tierras=mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for(final tiledObjectTierra in tierras!.objects){
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra,
          scales: Vector2(wScale,hScale));
      add(tierraBody);
    }

    _player = EmberPlayerBody(initialPosition: Vector2(128, canvasSize.y - 350,),
      iTipo: EmberPlayerBody.I_PLAYER_TANYA,tamano: Vector2(50,100)
    );
    _player2 = EmberPlayer2(position: Vector2(328, canvasSize.y - 150),
      size: Vector2(50,100)
    );

    //_player2 = EmberPlayer(position: Vector2(328, canvasSize.y - 150),);

    add(_player);
    add(_player2);
    //add(EmberPlayerBody(vector2Tamano: Vector2(40, 40,)));
    //camera.viewport = FixedResolutionViewport(resolution: Vector2(600, 300));
    //world.add(_player2);
  }
  
  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Color.fromRGBO(102, 178, 255, 1.0);
  }


}