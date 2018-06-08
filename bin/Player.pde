import javax.swing.JOptionPane;
public class Player {
  int counter, money, jailCounter,tileID, id;
  color c;
  boolean inJail, haveJailCard;
  String name;
  float x, y;
  float xspeed, yspeed;
  ArrayList<Property> properties;

  Player(String nombre, int num) {
    x = 21*width/22;
    y = 21*height/22;
    xspeed = -width/11;
    yspeed = 0;
    id = num;
    name = nombre;
    money = 1500;
    properties = new ArrayList<Property>();
    c = color(random(255), random(255), random(255));
  }

  void display() {
    fill(c);
    rect(x, y, 10, 10);
    text(name, x, y + 30);
    textSize(50);
    fill(204,255,245);
    noStroke();
    rect(5*width/11, height/11 +(id+1)*60-50, width/4,52);
    stroke(0);
    fill(c);
    text(money, 5*width/11, height/11+ (id+1)*60);
    textSize(11);
  }

  void move(int num) {
    for (int m = 0; m < num; m++) {
      x += xspeed;
      y += yspeed;
      checkCorner();
      tileID = (tileID+1)%40;
      if (tileID == 0) {
        changeMoney(200);
      }
    }
    checkTile(getCurrentPlayer().getCurrentTile());
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
  void changeMoney(int num){
    money += num;
    if ( money < 0 ) {
      JOptionPane.showMessageDialog(null, name + " has gone bankrupt", "Bankrupt", JOptionPane.INFORMATION_MESSAGE);
      players.remove(this);
      fill(204,255,245);
      noStroke();
      rect(5*width/11, height/11 +(id+1)*60-50, width/4,52);
      stroke(0);
      
      if (players.size() == 1) {
        JOptionPane.showMessageDialog(null, players.get(0) + " has won", "Winner", JOptionPane.INFORMATION_MESSAGE);
      }
    }
  }
  
  int getCurrentTile() {
    return tileID;
  }
  
  void getJailCard() {
    haveJailCard = true;
  }
  
  void goToJail() {
    inJail = true;
  }
  
  void addProperty(Property p) {
    properties.add(p);
  }
  //temp
  void printProperties() {
    for (Property p : properties) {
      System.out.println(p);
    }
  }
  
  String toString() {
    return name;
  }
}
