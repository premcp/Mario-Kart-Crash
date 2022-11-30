class Enemy {

  // vars
  float x;
  float y;
  float d;

  color fillC;

  float speed;

  float t;
  float b;
  float l;
  float r;

Animation enemyAnimation;
  // constructor

  Enemy(Animation startingAnimation) {
    x = random(0, width);
    y = 0;

    d = 40;

enemyAnimation = startingAnimation;


    speed = random(5,12);

    fillC = color (random (0, 255), random (0, 255), random (0, 255));
  }

  void render() {
    enemyAnimation.display(x,y);
  }

  void move() {
    y += speed;
  }


  void reset() {
    if (y >= height) {
      y = 0;
      x = random(0, width);
    }
  }

  void hitbox() {
    t = y - d/2;
    b = y + d/2;
    l = x - d/2;
    r = x + d/2;
  }

  void collide(Player aPlayer) {

    if (b > aPlayer.t && t < aPlayer.b && l < aPlayer.r && r > aPlayer.l) {
      startTime = millis();
      deadSound.play();
      gameStop = true;
    }
  }
}
