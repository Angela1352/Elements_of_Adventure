void play() {
  if (score == 3) mode = GAMEOVER;

  if (player.getY() > 900) {
    playerReset();
  }

  int scoreX, scoreY, scoreS;

  scoreX = 25;
  scoreY = 25;
  scoreS = 30;

  if (score == 1) {
    image(checkpoint, scoreX, scoreY, scoreS+8, scoreS);
  } else if (score == 2) {
    image(checkpoint, scoreX, scoreY, scoreS+8, scoreS);
    image(checkpoint, scoreX+45, scoreY, scoreS+8, scoreS);
  } else if (score == 3) {
    image(checkpoint, scoreX, scoreY, scoreS+8, scoreS);
    image(checkpoint, scoreX+45, scoreY, scoreS+8, scoreS);
    image(checkpoint, scoreX+90, scoreY, scoreS+8, scoreS);
  }
}
