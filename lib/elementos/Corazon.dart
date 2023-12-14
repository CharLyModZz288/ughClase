

import 'package:flame/components.dart';
import 'package:ugh2/games/UghGame.dart';

import '../games/UghGame2.dart';

class Corazon extends SpriteComponent with HasGameRef<UghGame2>{


  Corazon({required super.position,required super.size});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite=Sprite(game.images.fromCache('heart.png'));
    anchor=Anchor.center;
    return super.onLoad();
  }
}