class FFlag extends FGameObject {

  FFlag(float x, float y) {
    super();
    setPosition(x, y);
    setName("checkpoint");
    attachImage(checkpoint);
    setStatic(true);
    setSensor(true);
  }

  void act() {
    if (isTouching("player")) {
      //setStatic(false);
      setPosition(-500, 500);
    }
  }
}
