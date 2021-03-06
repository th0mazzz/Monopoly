import javax.swing.JOptionPane;
public class Player {
  final int boardWidth = height;
  final int offset = width - height;
  int textWidth, textHeight;
  
  int counter, money, jailCounter,tileID, id;
  color c;
  boolean inJail, haveJailCard;
  int inJailCounter;
  String name;
  float x, y;
  float xspeed, yspeed;
  ArrayList<Property> properties;
  Property[] redMono, orangeMono, yellowMono, greenMono, liblueMono, dkblueMono, purpleMono, brownMono, rrMono, utilMono;
  int redSize, orangeSize, yellowSize, greenSize, liblueSize, dkblueSize, purpleSize, brownSize, rrSize, utilSize;
  
  

  Player(String nombre, int num, int _money) {
    x = 21*boardWidth/22;
    y = 21*height/22;
    xspeed = -boardWidth/11;
    yspeed = 0;
    id = num;
    name = nombre;
    money = _money;
    properties = new ArrayList<Property>();
    c = color(random(255), random(255), random(255));
    
    if (id < numPlayers/2) {
      textWidth = width - offset + offset/5;
    } else {
      textWidth = width - offset + 3*offset/5;
    }
    
    textHeight = height/11 + ((id+1)%(numPlayers/2))*60;
    inJailCounter = 0;
    
    redMono = new Property[3];
    orangeMono = new Property[3];
    yellowMono = new Property[3];
    greenMono = new Property[3];
    liblueMono = new Property[3];
    dkblueMono = new Property[2];
    purpleMono = new Property[3];
    brownMono = new Property[2];
    rrMono = new Property[4];
    utilMono = new Property[2];
   
  }

  void display() {
    fill(c);
    rect(x, y, 10, 10);
    text(name, x, y + 30);
    textSize(20);
    fill(204,255,245);
    noStroke();
    rect(textWidth, textHeight - 50, offset/4,52);
    stroke(0);
    fill(c);
    text(name+ ": " + money, textWidth, textHeight);
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
            if(playerOn.getNumHotels() == 0){
              if(players.get(playerOn.getOwnerID()).checkMono(playerOn)){
                 transaction = playerOn.getBaseRent()*2;
                 changeMoney(-transaction);
              }
              transaction = playerOn.getBaseRent();
               changeMoney(-transaction);
            }else{
              transaction = playerOn.getRentHotel();
               changeMoney(-transaction);
            }
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
       //println(playerOn.getName());
       //println(propOwner);
       players.get(propOwner).changeMoney(transaction);
       return transaction;
     }else{
       return 0; 
     }
  }
  
  boolean buildHouse(Property p){
     return p.addHouse();
  }
  
  boolean sellHouse(Property p){
     return p.rmHouse(); 
  }
  
  boolean buildHotel(Property p){
    return p.addHotel();
  }
  
  boolean sellHotel(Property p){
    return p.rmHotel();
  }
  
  void changeMoney(int num){
    money += num;
    if ( money < 0 ) {
      JOptionPane.showMessageDialog(null, name + " has gone bankrupt!", "Bankrupt", JOptionPane.INFORMATION_MESSAGE);
      players.remove(this);
      numPlayers--;
      for(Property p : properties){
         p.setOwnerID(-1); 
      }
      fill(204,255,245);
      noStroke();
      rect(5*boardWidth/11, height/11 +(id+1)*60-50, boardWidth/4,52);
      stroke(0);
      
      if (players.size() == 1) {
        JOptionPane.showMessageDialog(null, players.get(0) + " has won!", "Winner", JOptionPane.INFORMATION_MESSAGE);
      }
    }
  }
  
  int getCurrentTile() {return tileID;}
  
  void getJailCard() {
    haveJailCard = true;
  }
  
  void goToJail() {
    inJail = true;
  }
  
  boolean isInJail() {
    return inJail;
  }
  
  boolean jailCard() {
    return haveJailCard;
  }
  
  void useJailCard() {
    haveJailCard = false;
    inJail = false;
    inJailCounter = 0;
  }
  
  void payJailFee() {
    changeMoney(-50);
    inJail = false;
    inJailCounter = 0;
  }
  
  void failDouble() {
    inJailCounter++; 
  }
  
  int getJailCounter() {
    return inJailCounter; 
  }
    
  String getName(){return name;}
  int getMoney(){return money;}
  color getColor(){return c;}
  
  void addProperty(Property p) {
    properties.add(p);
    addToMono(p);
  }
  
  void addToMono(Property p){
    if(p.getColor() == -65536){
      redMono[redSize] = p;
      redSize++;
    }
    if(p.getColor() == -26317){
      orangeMono[orangeSize] = p;
      orangeSize++;
    }
    if(p.getColor() == -256){
      yellowMono[yellowSize] = p;
      yellowSize++;
    }
    if(p.getColor() == -16711936){
      greenMono[greenSize] = p;
      greenSize++;
    }
    if(p.getColor() == -4980737){
      liblueMono[liblueSize] = p;
      liblueSize++;
    }
    if(p.getColor() == -16776961){
      dkblueMono[dkblueSize] = p;
      dkblueSize++;
    }
    if(p.getColor() == -3407668){
      purpleMono[purpleSize] = p;
      purpleSize++;
    }
    if(p.getColor() == -10079488){
      brownMono[brownSize] = p;
      brownSize++;
    }
    if(p.getColor() == -657937){
      rrMono[rrSize] = p;
      rrSize++;
    }
    if(p.getColor() == -2565952){
      utilMono[utilSize] = p;
      utilSize++;
    }
  }
  
  boolean checkMono(Property p){
    if(p.getColor() == -65536){
      return isRedMono();
    }
    if(p.getColor() == -26317){
      return isOrangeMono();
    }
    if(p.getColor() == -256){
      return isYellowMono();
    }
    if(p.getColor() == -16711936){
      return isGreenMono();
    }
    if(p.getColor() == -4980737){
      return isLiblueMono();
    }
    if(p.getColor() == -16776961){
      return isDkblueMono();
    }
    if(p.getColor() == -3407668){
      return isPurpleMono();
    }
    if(p.getColor() == -10079488){
      return isBrownMono();
    }
    return false;
  }
  
  boolean isRedMono(){return redMono.length == redSize;}
  boolean isOrangeMono(){return orangeMono.length == orangeSize;}
  boolean isYellowMono(){return yellowMono.length == yellowSize;}
  boolean isGreenMono(){return greenMono.length == greenSize;}
  boolean isLiblueMono(){return liblueMono.length == liblueSize;}
  boolean isDkblueMono(){return dkblueMono.length == dkblueSize;}
  boolean isPurpleMono(){return purpleMono.length == purpleSize;}
  boolean isBrownMono(){return brownMono.length == brownSize;}
  //we don't need checkers for RR or util b/c their rent is based on numbers, not if there is mono
  //plus you can't build on them anyway
  

  int getRrSize(){return rrSize;}
  int getUtilSize(){return utilSize;}
  
  String toString() {
    return name;
  }
}
