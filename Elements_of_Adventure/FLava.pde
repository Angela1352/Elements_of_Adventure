class FLava extends FGameObject {

  int timer, frame;

  FLava(float x, float y) {
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true);
    setSensor(true);
    frame = 0;
    timer = 0;
  }

  void act() {
    animate();
  }


  void animate() {
    timer++;
    if (timer <= 300) lavaState = lavaIdle;
    else if (timer > 300) lavaState = lavaBubble;
    if (timer == 600) timer = 0;

    if (frame >= lavaState.length) frame = 0;
    if (frameCount %10 == 0) {
      attachImage(lavaState[(int) random (frame)]);
      frame++;
    }
  }
}
