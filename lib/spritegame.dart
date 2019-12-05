import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:spritemove/char.dart';

class SpriteGame extends Game with TapDetector{

  Size screenSize;
  Char char;

  SpriteGame(this.screenSize) {
    char = Char(screenSize);
  }

  @override
  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint paint = Paint();
    paint.color = Color(0xffe9f0f5);
    canvas.drawRect(rect, paint);
    char.render(canvas);
  }

  @override
  void update(double t) {
    char.update(t);
    // TODO: implement update
  }

  void resize(Size size) {
    this.screenSize = size;
  }

  @override
  void onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    char.setTarget(Position(x,y));
  }

}