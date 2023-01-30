class FHammerBros extends FGameObject {
  int direction;
  int speed = 50;
  int frame = 0;
  int lives = 1;

  final int L = -1;
  final int R = 1;

  FHammerBros(float x, float y) {
    super();
    direction = R;

    setPosition(x, y);
    setName("hammerBro");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
    hammer();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(hammerBros[frame]);
      if (direction == L) attachImage(reverseImage(hammerBros[frame]));
      frame++;
    }
  }

  void collide() {
    if  (isTouching("stone")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY() - 32/2) {
        world.remove(this);
        enemies.remove(this);
        die.rewind();
        die.play();
      } else {
        playerReset();
      }
    }
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }


  void hammer() {

    FBody ham = new FBox(32, 32);
    ham.attachImage(hammer);
    if (frameCount % 200 == 0) {
      world.add(ham);
      ham.setName("hammer");
      ham.setPosition(getX(), getY());
      ham.setVelocity(400*direction, -450);
      ham.setAngularVelocity(20);
      ham.setSensor(true);
    }
  }
}
