class FPlayer extends FGameObject {

  int frame;
  int direction;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(0, 0);
    setName("player");
    setRotatable(false);
    lives = 3;
  }

  void act() {
    input();
    collisions();
    animate();
    showLives();
  }


  void input() {
    if (mode == PLAY) {
      float vy = getVelocityY();
      float vx = getVelocityX();

      if (abs(vy) < 0.1) action = idle;
      if (akey && lives >= 1) {
        setVelocity(-200, vy);
        action = run;
        direction = L;
      }
      if (dkey && lives >= 1) {
        setVelocity(200, vy);
        action = run;
        direction = R;
      }
      if (wkey && lives >= 1) {
        ArrayList<FContact> contacts = getContacts();
        if (contacts.size() > 1) {
          setVelocity(vx, -600);
        }
      }
      if (abs(vy) > 0.1) action = jump;


      //FLY
      //if (wkey) setVelocity (vx, -250);
      //if (abs(vy) > 0.1) action = jump;
    }
  }


  void collisions() {
    if (isTouching("spike") || isTouching("lava")) {
      playerReset();
    }

    if (isTouching("water")) {
      if (akey) setVelocity(-50, 0);
      if (dkey) setVelocity(50, 0);

      setVelocity(getVelocityX(), getVelocityY()/4);
    }

    if (isTouching("trampoline")) {
      bounce.rewind();
      bounce.play();
    }

    if (isTouching("hammer")) {
      playerReset();
    }

    if (isTouching("checkpoint")) {
      score++;
      win.rewind();
      win.play();
    }
  }


  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount %5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }


  void showLives() {
    int livesX, livesY, livesS;

    livesX = 475;
    livesY = 25;
    livesS = 30;

    if (lives == 3) {
      image(heart, livesX, livesY, livesS+8, livesS);
      image(heart, livesX+45, livesY, livesS+8, livesS);
      image(heart, livesX+90, livesY, livesS+8, livesS);
    } else if (lives == 2) {
      image(heart, livesX, livesY, livesS+8, livesS);
      image(heart, livesX+45, livesY, livesS+8, livesS);
    } else if (lives == 1) {
      image(heart, livesX, livesY, livesS+8, livesS);
    } else if (lives <= 0) {
      mode = GAMEOVER;
    }
  }
}
