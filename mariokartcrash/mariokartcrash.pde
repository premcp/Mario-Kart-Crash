


import processing.sound.*;



// declaring my vars
Player p1;



boolean gameStop = false;
SoundFile deadSound;
SoundFile background;

// my states timer
int startTime;
int endTime;
int interval = 3000;

// enemy timer
int startTime2;
int endTime2;
int interval2 = 7000;

// block timer
int startTime3;
int endTime3;
int interval3 = 20000;


// finite state machine
int state = 0;


// my images (animation) for game
PImage[] playerCarImage = new PImage[4];
PImage[] enemyCarImage = new PImage[5];
PImage[] blockImages = new PImage[3];

// declare start screen and end screen vars
PImage start;
PImage mario;
PImage mid;
PImage over;


// enemies and blocks list of arrays
ArrayList<Enemy> enemyList;
ArrayList<Block> blockList;


// animations for each class
Animation p1Animation;
Animation enemyAnimation;
Animation blockAnimation;


// points earned from blocks
int blockPoints;


// time level 1 starts
int timeGameStarts;

int gameOverTimeScore;

void setup() {
  size (800, 600);

  blockPoints = 0;

  // making new animations for everything
  p1Animation = new Animation(playerCarImage, 0.1, 1.0);
  enemyAnimation = new Animation(enemyCarImage, 0.1, 1.0);
  blockAnimation = new Animation(blockImages, 0.1, 0.5);



  // initializing enemy and block arrays
  enemyList = new ArrayList<Enemy>();
  blockList = new ArrayList<Block>();



  // fill array of player car images
  for (int i=0; i<playerCarImage.length; i++) {
    playerCarImage[i] = loadImage("mariocar"+i+".png");
  }

  // fill array of enemy car images
  for (int i=0; i<enemyCarImage.length; i++) {
    enemyCarImage[i] = loadImage("enemy"+i+".png");
  }

  // fill array of block images
  for (int i=0; i<blockImages.length; i++) {
    blockImages[i] = loadImage("question"+i+".png");
  }


  startTime = millis();
  startTime2 = millis();
  startTime3 = millis();

  // initialize player var
  p1 = new Player(width/2, height - 100, 50, 50, p1Animation);


  // background music
  background = new SoundFile(this, "music.wav");


  // determining the sound when car crashes
  deadSound = new SoundFile(this, "death.wav");



  // initialize start screen image
  start = loadImage("marioscreen.jpg");
  mid = loadImage("road.jpg");
  over = loadImage("gameover.jpg");
  mario = loadImage("mario.jpg");
}


void draw() {
  background (42);
  if (!background.isPlaying()) {
    background.play();
  }

  switch (state) {

    // start screen
  case 0:
    rectMode(CENTER);
    imageMode(CENTER);
    image(start, width/2, height/2);
    textSize (50);
    fill(0, 0, 0);
    text("PRESS SPACE TO START", 140, height/2 + 60);
    break;



    // the game itself
  case 1:
    rectMode(CENTER);
    image(mid, width/2, height/2);
    mid.resize(width, height);
    int timerdisplay = (millis() - timeGameStarts)/1000 + blockPoints;
    fill(255, 255, 255);
    rect(55, 80, 50, 50);
    fill(255, 0, 0);
    text(timerdisplay, 50, 100);


    p1Animation.isAnimating = true;
    enemyAnimation.isAnimating = true;
    blockAnimation.isAnimating = true;






    endTime = millis();
    endTime2 = millis();
    endTime3 = millis();



    p1.render();






    if (gameStop == false) {

      p1.move();
      p1.hitbox();


      // enemy list of array to render on screen
      for (Enemy aEnemy : enemyList) {
        aEnemy.render();
      }

      // block list of array to render on screen
      for (Block aBlock : blockList) {
        aBlock.render();
      }


      // adding new enemy each interval of seconds
      if (endTime2 - startTime2 >= interval2) {
        enemyList.add(new Enemy(enemyAnimation));
        startTime2 = millis();
      }

      // adding new block each interval of seconds
      if (endTime3 - startTime3 >= interval3) {
        blockList.add(new Block(blockAnimation));
        startTime3 = millis();
      }


      // enemy functions for the list of enemies
      for (Enemy aEnemy : enemyList) {
        aEnemy.move();
        aEnemy.reset();
        aEnemy.hitbox();
        aEnemy.collide(p1);
      }

      for (Block aBlock : blockList) {
        aBlock.move();
        aBlock.reset();
        aBlock.hitbox();
        aBlock.collide(p1);
      }
imageMode(CENTER);
image(mario, width/2 - 100, height-30);
mario.resize(75,75);

      break;
    }
    if (gameStop == true) {
      if (endTime - startTime <= interval) {
        state = 2;
        gameOverTimeScore = (millis() - timeGameStarts)/1000;
      }
    }

    // game over screen

  case 2:
    rectMode(CENTER);
    image(over, width/2, height/2);
    over.resize(width, height);

    fill(255, 0, 0);
    text(gameOverTimeScore+blockPoints, width/2, height - 100);
    text("FINAL TIME:", width/2 - 300,  height - 100);
    text("SECONDS", width/2 + 100,  height - 100);
    text("PRESS R TO RESTART", width/2 - 215, height/2 - 200);
    if (background.isPlaying()) {
      background.stop();
    }
  }
}


// player movement keys
void keyPressed() {
  if (keyCode == LEFT) {
    p1.isMovingLeft = true;
  }
  if (keyCode == RIGHT) {
    p1.isMovingRight = true;
  }
  if (keyCode == ' ') {
    state = 1;
    timeGameStarts = millis();
  }
  
  // restarts game
  if (key == 'r') {
    state = 0;
    gameStop = false;
    setup();
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    p1.isMovingLeft = false;
  }
  if (keyCode == RIGHT) {
    p1.isMovingRight = false;
  }
}
