public class Player {
  int counter, money, jailCounter;
  color c;
  boolean inJail, haveJailCard;
  String name;
  float x, y;
  float xspeed, yspeed;

  Player(String nombre) {
    x = 21*width/22;
    y = 21*height/22;
    xspeed = -width/11;
    yspeed = 0;

    name = nombre;
    money = 1500;
    c = color(random(255), random(255), random(255));
  }

  void display() {
    fill(c);
    rect(x, y, 10, 10);
    text(name, x, y + 30);
  }

  void move(int num) {
    for (int m = 0; m < num; m++) {
      x += xspeed;
      y += yspeed;
      checkCorner();
    }
  }

  void checkCorner() {
    // left bottom
    if ( x == width/22 && y == 21*height/22 ) {
      xspeed = 0;
      yspeed = -height/11;
    }
    // left top
    if ( x == width/22 && y == height/22) {
      xspeed = width/11;
      yspeed = 0;
    }
    // right top
    if ( x == 21*width/22 && y == height/22) {
      xspeed = 0;
      yspeed = height/11;
    }
    // right bottom
    if ( x == 21*width/22 && y == 21*height/22) {
      xspeed = -width/11;
      yspeed = 0;
    }
  }

  String toString() {
    return name;
  }
}
