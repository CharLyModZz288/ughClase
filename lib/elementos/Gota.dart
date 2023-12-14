
import 'package:flame/components.dart';

import '../games/UghGame.dart';
import '../games/UghGame2.dart';

class Gota extends SpriteAnimationComponent
    with HasGameRef<UghGame2>{

  Gota({
    required super.position, required super.size
  }) : super(anchor: Anchor.center);


  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.12,
      ),
    );

    return super.onLoad();
  }

}