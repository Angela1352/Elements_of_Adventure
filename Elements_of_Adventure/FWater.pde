class FWater extends FGameObject {

  int frame;

  FWater(float x, float y) {
    super();
    setPosition(x, y);
    setName("water");
    setStatic(true);
    setSensor(true);
  }

  void act() {
    //if (isTouching("player")) {
    //  setSensor(true);
    //  //setFriction(-3);
    //}
    animate();
  }

  void animate() {
    if (frame >= water.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(water[frame]);
      frame++;
    }
  }
}
