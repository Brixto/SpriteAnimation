import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';

class Char extends PositionComponent {
  Animation walk;
  Size screenSize;
  Position target;
  double speed = 80;
  Animation currentAnimation;
  List animations = List();

  Char(this.screenSize) {
    const amountOfFrames = 31;

    final spritesheet = SpriteSheet(
      imageName: 'player_walk.png',
      textureWidth: 64,
      textureHeight: 64,
      columns: 31,
      rows: 8,
    );

    currentAnimation = spritesheet.createAnimation(0, stepTime: 0.05);
    for (int i = 0; i < spritesheet.rows; i++) {
      animations.add(spritesheet.createAnimation(i, stepTime: 0.05));
    }

    //walk = Animation.sequenced('southwest.png', amountOfFrames, textureWidth: 258, stepTime: 0.05);
    this.x = 100;
    this.y = 100;
    this.target = Position(this.x, this.y);
    this.width = 64;
    this.height = 64;
  }

  void setTarget(Position target) {
    this.target = target;
  }

  @override
  void render(Canvas c) {
    Sprite sprite = currentAnimation.getSprite();
    sprite.renderPosition(c, Position(x - width / 2, y - height / 2),
        size: Position(width, height));
  }

  @override
  void update(double t) {
    var pos = Position(x, y);
    Position dir = (this.target - pos).normalize();
    var angle = dir.angleDeg();
    if (angle >= -22.5 && angle <= 22.5) {
      currentAnimation = animations.first;
    } else if (angle > 22.5 && angle <= 67.5) {
      currentAnimation = animations[5];
    } else if (angle > 67.5 && angle <= 112.5) {
      currentAnimation = animations[4];
    } else if (angle > 112.5 && angle <= 157.5) {
      currentAnimation = animations[6];
    } else if (angle > 157.5 || angle <= -157.5) {
      currentAnimation = animations[7];
    } else if (angle > -157.5 && angle <= -112.5) {
      currentAnimation = animations[3];
    } else if (angle > -112.5 && angle <= -67.5) {
      currentAnimation = animations[1];
    } else if (angle > -67.5 && angle <= -22.5) {
      currentAnimation = animations[2];
    }
    if (pos.distance(target) <= dir.length()) {
      pos = target;
    } else {
      pos.add(dir.times(t * speed));
    }

    setByPosition(pos);
    currentAnimation.update(t);
  }
}
