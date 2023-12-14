import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'games/UghGame2.dart';

void main() {
  runApp(
    const GameWidget<UghGame2>.controlled(
      gameFactory: UghGame2.new,
    ),
  );
}