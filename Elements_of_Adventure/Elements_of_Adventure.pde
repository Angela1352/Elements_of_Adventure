import fisica.*;
FWorld world;

//Angela Chen
//January 4, 2023
//1-2

//MUSIC
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// ================ GLOBAL VARIABLES =================

final int INTRO    = 0;
final int LEVEL    = 1;
final int PLAY     = 2;
final int PAUSE    = 3;
final int GAMEOVER = 4;
int mode;

//ffffff,000000,9c5a3c,ff0000,00ff00,0000ff,00fff2,8400ff,ff00ff,c9c9c9,ffff00,757575,008a25,a8ffbf,5a915c,452a2a,fa96fa,165218
//nothing,stone,trunk,lava,tree,water,ice,spikes,bridge,trampoline,goombas,walls,thwomp,flag,grass,dirt,hammer,TRdirt

//color palette
color white    = #FFFFFF;
color black    = #000000; //stone
color brown    = #9c5a3c; //trunk
color green    = #00ff00; //tree
color cyan     = #00fff2; //ice
color blue     = #0000FF; //water
color red      = #ff0000; //lava
color purple   = #8400ff; //spike
color pink     = #ff00ff; //bridge
color Lgrey    = #c9c9c9; //trampoline
color yellow   = #ffff00; //goombas
color Dgrey    = #757575; //wall
color thwomp   = #008a25; //thwomp
color Lgreen   = #a8ffbf; //checkpoint flag
color grass    = #5a915c;
color TRgrass  = #165218;
color dirtB    = #452a2a;
color Lpink    = #fa96fa; //hammerbro

//general
PImage map;
PImage fireMap, waterMap, iceMap, earthMap, heart;
int lives, score;

PFont font1;
Gif lightning;

//Sound Effects
Minim minim;
AudioPlayer theme, click, bounce, hit, win, grunt, die;

//buttons
Button start, exit, fireLvl, waterLvl, earthLvl, iceLvl;

//terrain images
PImage stone, treeTrunk, Ltree, Mtree, Ctree, Rtree, ice, spike, bridge, trampoline;
PImage TLDirt, LDirt, BLDirt, TDirt, dirt, BDirt, TRDirt, RDirt, BRDirt;
PImage thwomp0, thwomp1, checkpoint;
PImage intro, elements, fireS, waterS, iceS, earthS, hammer;

//character animations images
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

//enemy images
PImage[] goomba;
PImage[] hammerBros;

//lava animations images
PImage[] lavaIdle;
PImage[] lavaBubble;
PImage[] lavaState;

//water animations images
PImage[] water;

//map control
int gridSize = 32; //adjust to see what is going on
float zoom = 1.5;

//keyboard booleans
boolean mouseReleased, wasPressed;
boolean upkey, downkey, leftkey, rightkey, spacekey, wkey, akey, skey, dkey, qkey, ekey;

//objects and lists of objects
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
FPlayer player;


void setup() {
  size(600, 600);
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  initializeModes();
  loadImages();
  loadVariables();
  loadWorld(waterMap); //---------------------------------------------------
  loadPlayer();
}


void initializeModes() {
  //set up the default mode for things
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);
  mode = INTRO;
}


void loadImages() {
  fireMap    = loadImage("fireMap.png");
  waterMap   = loadImage("waterMap.png");
  iceMap     = loadImage("iceMap.png");
  heart      = loadImage("heart.png");
  stone      = loadImage("stone.png");
  treeTrunk  = loadImage("trunk.png");
  ice        = loadImage("ice.png");
  Ltree      = loadImage("Ltree.png");
  Mtree      = loadImage("Mtree.png");
  Ctree      = loadImage("Ctree.png");
  Rtree      = loadImage("Rtree.png");
  spike      = loadImage("spike.png");
  bridge     = loadImage("bridge.png");
  TLDirt     = loadImage("TLDirt.png");
  LDirt      = loadImage("LDirt.png");
  BLDirt     = loadImage("BLDirt.png");
  TDirt      = loadImage("TDirt.png");
  dirt       = loadImage("dirt.png");
  BDirt      = loadImage("BDirt.png");
  TRDirt     = loadImage("TRDirt.png");
  RDirt      = loadImage("RDirt.png");
  BRDirt     = loadImage("BRDirt.png");
  trampoline = loadImage("trampoline.png");
  intro      = loadImage("intro.jpg");
  elements   = loadImage("mapBkg.jpg");
  fireS      = loadImage("fireS.png");
  waterS     = loadImage("waterS.png");
  iceS       = loadImage("iceS.png");
  earthS     = loadImage("earthS.png");
  thwomp0    = loadImage("thwomp0.png");
  thwomp1    = loadImage("thwomp1.png");
  checkpoint = loadImage("checkpoint.png");
  hammer     = loadImage("hammer.png");

  treeTrunk.resize(32, 32);
  ice.resize(32, 32);
  checkpoint.resize(32, 32);
  thwomp0.resize(64, 64);
  thwomp1.resize(64, 64);

  //load actions for character
  idle = new PImage[30];
  for (int i = 0; i < 30; i++) idle[i] = loadImage("idle0.png");
  idle[29] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump.png");

  run = new PImage[3];
  run[0] = loadImage("run0.png");
  run[1] = loadImage("run1.png");
  run[2] = loadImage("run2.png");

  action = idle;


  //load enemies
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  hammerBros = new PImage[2];
  hammerBros[0] = loadImage("hammer0.png");
  hammerBros[1] = loadImage("hammer1.png");


  //load animations for lava
  lavaIdle = new PImage[1];
  lavaIdle[0] = loadImage("lava0.png");

  lavaBubble = new PImage[5];
  lavaBubble[0] = loadImage("lava1.png");
  lavaBubble[1] = loadImage("lava2.png");
  lavaBubble[2] = loadImage("lava3.png");
  lavaBubble[3] = loadImage("lava4.png");
  lavaBubble[4] = loadImage("lava5.png");
  lavaBubble[4].resize(gridSize, gridSize);

  lavaState = lavaIdle;


  //load animations for water
  water = new PImage[4];
  water[0] = loadImage("water0.png");
  water[1] = loadImage("water1.png");
  water[2] = loadImage("water2.png");
  water[3] = loadImage("water3.png");
}


void loadVariables() {
  map = fireMap;
  score = 0;

  //sound effects
  minim    = new Minim(this);
  theme    = minim.loadFile("theme.mp3");
  click    = minim.loadFile("click.mp3");
  bounce   = minim.loadFile("bounce.mp3");
  hit      = minim.loadFile("hit.mp3");
  win      = minim.loadFile("win.mp3");
  grunt    = minim.loadFile("grunt.mp3");
  die      = minim.loadFile("die.mp3");

  //buttons
  start    = new Button("START", width/2, 470, 180, 80, green, white);
  exit     = new Button("EXIT", width/2, 420, 180, 80, red, white);
  fireLvl  = new Button(fireS, 200, 250, 160, 160, purple, white);
  waterLvl = new Button(waterS, 400, 250, 160, 160, purple, white);
  earthLvl = new Button(earthS, 200, 465, 160, 160, purple, white);
  iceLvl   = new Button(iceS, 400, 465, 160, 160, purple, white);

  //fonts
  font1 = createFont("font1.ttf", 100);

  //gifs
  lightning = new Gif("lightning", ".gif", 4, 3, width/2, height/2, width, height);
}


void loadWorld(PImage img) {
  world = new FWorld(-2000, -2000, 2000, 2000); //can change numbers
  world.setGravity(0, 900);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x, y); //color of current pixel
      color s = img.get(x, y+1); //color south current pixel
      color w = img.get(x-1, y); //color west current pixel
      color e = img.get(x+1, y); //color east current pixel
      color n = img.get(x, y-1); //color north curent pixel
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      b.setFriction(4);
      b.setRestitution(0);
      if (c == black) { //stone block
        b.attachImage(stone);
        b.setName("stone");
        world.add(b);
      } else if (c == Dgrey) { //wall
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == cyan) { //ice block
        b.setFriction(0);
        b.attachImage(ice);
        b.setName("ice");
        world.add(b);
      } else if (c == brown) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      } else if (c == green && w != green) { //left
        b.attachImage(Ltree);
        b.setName("left tree");
        world.add(b);
      } else if (c == green && s == brown) { //center
        b.attachImage(Ctree);
        b.setName("center tree");
        world.add(b);
      } else  if (c == green && w == green && e == green) { //middle
        b.attachImage(Mtree);
        b.setName("middle tree");
        world.add(b);
      } else if (c == green && e !=green) { //right
        b.attachImage(Rtree);
        b.setName("right tree");
        world.add(b);
      } else if (c == purple) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == Lgrey) {
        b.attachImage(trampoline);
        b.setRestitution(1.5);
        b.setName("trampoline");
        world.add(b);
      } else if (c == pink) {
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == blue) {
        FWater water = new FWater(x*gridSize, y*gridSize);
        terrain.add(water);
        world.add(water);
      } else if (c == red) {
        FLava lava = new FLava(x*gridSize, y*gridSize);
        terrain.add(lava);
        world.add(lava);
      } else if (c == yellow) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else  if (c == thwomp) {
        FThwomp thp = new FThwomp(x*32, y*32);
        terrain.add(thp);
        world.add(thp);
      } else if (c == Lgreen) {
        FFlag flag = new FFlag(x*gridSize, y*gridSize);
        terrain.add(flag);
        world.add(flag);
      } else if (c == dirtB) {
        b.attachImage(dirt);
        world.add(b);
      } else if (c == grass && s != white && w != grass && w != dirtB) {
        b.attachImage(TLDirt);
        world.add(b);
      } else if (c == grass && n != grass  && n != blue && n != TRgrass && e == grass || e == TRgrass || e == dirtB && w == grass) {
        b.attachImage(TDirt);
        world.add(b);
      } else if (c == grass && n == grass && e == dirtB && s == grass) {
        b.attachImage(LDirt);
        world.add(b);
      } else if (c == grass && n == grass && s == grass && w == dirtB) {
        b.attachImage(RDirt);
        world.add(b);
      } else if (c == grass && n == grass && e == grass && s != grass && w != grass) {
        b.attachImage(BLDirt);
        world.add(b);
      } else if (c == grass && w == grass && e == grass) {
        b.attachImage(BDirt);
        world.add(b);
      } else if (c == grass && n == TRgrass && w == grass && e != grass && s != grass) {
        b.attachImage(BRDirt);
        world.add(b);
      } else if (c == TRgrass) {
        b.attachImage(TRDirt);
        world.add(b);
      } else if (c == Lpink) {
        FHammerBros hammer = new FHammerBros(x*32, y*32);
        enemies.add(hammer);
        world.add(hammer);
      }
    }
  }
}


void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}


void draw() {
  background(#87CEEB);

  drawWorld();
  actWorld();
  click();
  if (mode == INTRO) {
    intro();
  } else if (mode == LEVEL) {
    level();
  } else if (mode == PLAY) {
    play();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  }
}


void actWorld() {
  player.act();
  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}


void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}


void playerReset() {
  player.setPosition(0, 0);
  player.setVelocity(0, 0);
  player.direction = 1;
  lives--;
  hit.rewind();
  hit.play();
}
