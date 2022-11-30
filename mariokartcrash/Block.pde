class Block {


  // vars
  float x;
  float y;
  float w;
  float h;

  color fillC;

  float speed;

  float t;
  float b;
  float l;
  float r;

Animation blockAnimation;
  // constructor

  Block(Animation startingAnimation) {
    x = random(0, width);
    y = 0;

    w = 40;
    h = 40;

blockAnimation = startingAnimation;

    speed = random(3, 10);

    fillC = color (random (0, 255), random (0, 255), random (0, 255));
  }

  void render() {
    blockAnimation.display(x,y);
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
    t = y - h/2;
    b = y + h/2;
    l = x - w/2;
    r = x + w/2;
  }

  void collide(Player aPlayer) {



    if (b > aPlayer.t && t < aPlayer.b && l < aPlayer.r && r > aPlayer.l) {
      startTime = millis();
      blockPoints += int (random(1, 5));
      y+=1000;
    }
  }
}
