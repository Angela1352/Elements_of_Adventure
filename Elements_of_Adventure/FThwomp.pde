class FThwomp extends FGameObject {

  FThwomp(float x, float y) {
    super();
    setPosition(x, y+30);
    setName("thwomp");
    attachImage(thwomp0);
    setStatic(true);
    setSensor(false);
  }

  void act() {
    if (abs((player.getX() - getX())) <= 32 && player.getY() > (getY()+30)) {
      setStatic(false);
      attachImage(thwomp1);
      grunt.rewind();
      grunt.play();
    }
    if (!isStatic()) {
      if (isTouching("player") && (player.getY()-16) > getY()) {
        playerReset();
      }
    }
  }
}
