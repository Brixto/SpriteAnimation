import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class Char extends PositionComponent {

  Animation walk;
  Size screenSize;
  Position target;
  double speed = 150;

  Char(this.screenSize) {
    const amountOfFrames = 31;
   walk = Animation.sequenced('southwest.png', amountOfFrames, textureWidth: 258, stepTime: 0.05);
   this.x = 100;
   this.y = 100;
   this.target = Position(this.x, this.y);
   this.width = 258;
   this.height = 258;
  }

  void setTarget(Position target) {
    this.target = target;
  }

  @override
  void render(Canvas c) {
    Sprite sprite = walk.getSprite();
    sprite.renderPosition(c, Position(x - width / 2,y - height / 2), size: Position(width, height));
  }

  @override
  void update(double t) {
    var pos = Position(x, y);
    Position dir = (this.target - pos).normalize();
    if(pos.distance(target) <= dir.length()) {
      pos = target;
    } else {
      pos.add(dir.times(t * speed));
    }


    setByPosition(pos);
    walk.update(t);
  }

}