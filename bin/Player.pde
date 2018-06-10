import javax.swing.JOptionPane;
public class Player {
  final int boardWidth = height;
  
  int counter, money, jailCounter,tileID, id;
  color c;
  boolean inJail, haveJailCard;
  String name;
  float x, y;
  float xspeed, yspeed;
  ArrayList<Property> properties;

  Player(String nombre, int num) {
    x = 21*boardWidth/22;
    y = 21*height/22;
    xspeed = -boardWidth/11;
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
    textSize(20);
    fill(204,255,245);
    noStroke();
    rect(width - width*2/11, height/11 +(id+1)*60-50, width/4,52);
    stroke(0);
    fill(c);
    text(name+ ": " + money, width - width*2/11, height/11+ (id+1)*60);
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
    if ( x == boardWidth/22 && y == 21*height/22 ) {
      xspeed = 0;
      yspeed = -height/11;
    }
    // left top
    if ( x == boardWidth/22 && y == height/22) {
      xspeed = boardWidth/11;
      yspeed = 0;
    }
    // right top
    if ( x == 21*boardWidth/22 && y == height/22) {
      xspeed = 0;
      yspeed = height/11;
    }
    // right bottom
    if ( x == 21*boardWidth/22 && y == 21*height/22) {
      xspeed = -boardWidth/11;
      yspeed = 0;
    }
  }
  
  int payRent(){
    Property playerOn = props[getCurrentTile()];
     if(playerOn.getOwnerID() != -1){
       int transaction = 0;
       if(playerOn.getNumHotels() == 1){
         transaction = playerOn.getRentHotel();
          changeMoney(-transaction);
       }else{
          if(playerOn.getNumHouses() == 0){
            transaction = playerOn.getBaseRent();
             changeMoney(-transaction);
          }
          if(playerOn.getNumHouses() == 1){
            transaction = playerOn.getRentOne();
             changeMoney(-transaction);
          }
          if(playerOn.getNumHouses() == 2){
            transaction = playerOn.getRentTwo();
             changeMoney(-transaction);
          }
          if(playerOn.getNumHouses() == 3){
            transaction = playerOn.getRentThree();
             changeMoney(-transaction);
          }
          if(playerOn.getNumHouses() == 4){
            transaction = playerOn.getRentFour();
             changeMoney(-transaction);
          }
       }
       int propOwner = playerOn.getOwnerID();
       println(playerOn.getName());
       println(propOwner);
       players.get(propOwner).changeMoney(transaction);
       return transaction;
     }else{
       return 0; 
     }
  }
  
  void changeMoney(int num){
    money += num;
    if ( money < 0 ) {
      JOptionPane.showMessageDialog(null, name + " has gone bankrupt!", "Bankrupt", JOptionPane.INFORMATION_MESSAGE);
      players.remove(this);
      fill(204,255,245);
      noStroke();
      rect(5*boardWidth/11, height/11 +(id+1)*60-50, boardWidth/4,52);
      stroke(0);
      
      if (players.size() == 1) {
        JOptionPane.showMessageDialog(null, players.get(0) + " has won!", "Winner", JOptionPane.INFORMATION_MESSAGE);
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
  
  String getName(){
     return name; 
  }
  
  int getMoney(){
     return money; 
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
