void gameover() {
  lightning.show();
  tint(255, 160);
  image(intro, 300, 290, 600, 800);
  noTint();

  textFont(font1);
  textSize(35);
  exit.show();
  if (exit.clicked) exit();


  //Gameover/Win text
  textSize(55 + 10*sin(angle));
  angle = angle + 0.2;
  if (score == 3) {
    fill(black);
    text("YOU PASSED", 297, 183);
    fill(green);
    text("YOU PASSED", 303, 183);
  } else if (score < 3) {
    fill(black);
    text("GAMEOVER", 297, 183);
    fill(red);
    text("GAMEOVER", 303, 183);
  }
}
