class FGoomba extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y+16);
    setName("goomba");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }


  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }

    if (isTouching("player")) {
      if (player.getY() < getY()-25) {
        world.remove(this);
        enemies.remove(this);
        die.rewind();
        die.play();
      } else {
        playerReset();
      }
    }
  }


  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
