int counter, money, jailCounter;
boolean inJail, haveJailCard;
String name;
float x, y;
float xspeed, yspeed;

public class Player {
  Player() {
      x = 21*width/22;
      y = 21*height/22;
      xspeed = -width/11;
      yspeed = 0;
  }
  
  void display() {
    rect(x,y, 10,10);
  }
  
  void move(int num) {
    for (int m = 0; m < num; m++) {
      x += xspeed;
      y += yspeed;
    }
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
}
