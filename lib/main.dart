import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:spritemove/spritegame.dart';

void main() async {
  final Size size = await Flame.util.initialDimensions();
  SpriteGame game = SpriteGame(size);
  runApp(game.widget);
}