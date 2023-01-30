float angle = 0;

void intro() {
  theme.play();
  lightning.show();
  tint(255, 160);
  image(intro, 300, 290, 600, 800);
  noTint();

  textFont(font1);
  textSize(35);
  start.show();
  if (start.clicked) mode = LEVEL;

  //Elements of Adventure text
  textSize(55 + 10*sin(angle));
  angle = angle + 0.2;
  fill(black);
  text("ELEMENTS", 297, 133);
  text("ADVENTURE", 297, 323);
  textSize(40);
  text("OF", 297, 223);
  textSize(55 + 10*sin(angle));
  fill(green);
  text("ELEMENTS", 303, 127);
  text("ADVENTURE", 303, 317);
  textSize(40);
  text("OF", 303, 223);
}
