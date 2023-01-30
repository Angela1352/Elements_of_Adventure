int counter = 0;

void level() {
  image(elements, width/2, height/2, 800, 600);
  chooseMapText();

  fireLvl.show();
  waterLvl.show();
  iceLvl.show();
  earthLvl.show();

  textSize(22);
  fill(white);
  text("FIRE", 200, 150);
  text("WATER", 400, 150);
  text("ICE", 200, 365);
  text("EARTH", 400, 365);
  image(fireS, 200, 253, 160, 160);
  image(waterS, 400, 250, 130, 155);
  image(iceS, 200, 465, 145, 145);
  image(earthS, 400, 465, 150, 150);


  if (fireLvl.clicked) {
    map = fireMap;
    mode = PLAY;
  }

  if (waterLvl.clicked) {
    map = waterMap;
    mode = PLAY;
  }

  if (iceLvl.clicked) {
    map = iceMap;
  }

  if (earthLvl.clicked) {
    map = earthMap;
  }
}

void chooseMapText() {
  counter++;

  if (counter <= 18) {
    textSize(60);
    fill(purple);
    text("SELECT LEVEL", 306, 75);
    fill(white);
    text("SELECT LEVEL", 302, 75);
  } else if (counter > 15) {
    if (counter ==  30) counter = 0;
  }
}
