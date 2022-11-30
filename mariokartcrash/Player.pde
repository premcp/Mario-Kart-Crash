class Player {

  // variables
  int x;
  int y;

  int w;
  int h;

  boolean isMovingLeft;
  boolean isMovingRight;

  int speed;
  
  int t;
  int b;
  int l;
  int r;
  
  Animation playerAnimation;

  // constructor
  Player(int startingX, int startingY, int startingW, int startingH, Animation startingAnimation) {
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
   playerAnimation = startingAnimation;

    isMovingLeft = false;
    isMovingRight = false;

    speed = 10;
  }


  // functions

  void render() {
   rectMode(CENTER);
   playerAnimation.display(x + 10,y + 60);
  }

  void move() {
    if (isMovingLeft == true) {
      x -= speed;
    }
    if (isMovingRight == true) {
      x += speed;
    }
  }
  
  void hitbox(){
     t = y;
    b = y + h;
    l = x;
    r = x + w;
  }
}
