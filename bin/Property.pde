public class Property{
 final int boardWidth = height;
 final int oneSide = boardWidth / 11; //for 770x770, this is 70
  
 int xcor, ycor;
 int numHouses, numHotels;
 int ownerID;
 String name, des;
 boolean isMort, specialProp;
 color _color;
 
 //variables that have to do with $
 int value;
 int baseRent;
 int rentOne, rentTwo, rentThree, rentFour;
 int rentHotel;
 int mortPrice;
 int buildingPrice;
 
  public Property(int x, int y, int v, String nombre, String write,  
                  int red, int green, int blue,
                  boolean special){
    xcor = x;
    ycor = y;
    value = v;
    name = nombre;
    des = write;
    _color = color(red,green,blue);
    ownerID = -1; //-1 means bank's (not owned by player yet)
    isMort = false;
    specialProp = special;
  }
  
   void setBaseRent(int num){baseRent = num;}
   void setRentOne(int num){rentOne = num;}
   void setRentTwo(int num){rentTwo = num;}
   void setRentThree(int num){rentThree = num;}
   void setRentFour(int num){rentFour = num;}
   void setRentHotel(int num){rentHotel = num;}
   void setMortPrice(int num){mortPrice = num;}
   void setBuildingPrice(int num){buildingPrice = num;}
  
  int getValue(){return value;}
  int getBaseRent(){return baseRent;}
  int getRentOne(){return rentOne;}
  int getRentTwo(){return rentTwo;}
  int getRentThree(){return rentThree;}
  int getRentFour(){return rentFour;}
  int getRentHotel(){return rentHotel;}
  int getMortPrice(){return mortPrice;}
  int getBuildingPrice(){return buildingPrice;}
  
  int getXcor(){return xcor;}
  int getYcor(){return ycor;}
  int getNumHouses(){return numHouses;}
  int getNumHotels(){return numHotels;}
  int getOwnerID(){return ownerID;}
  String getName(){return name;}
  String getDes(){return des;}
  boolean getIsMort(){return isMort;}
  boolean getSpecialStatus(){return specialProp;}
  color getColor(){return _color;}
  
  String getOwnerName(){
    if(ownerID != -1){
      return players.get(ownerID).getName(); 
    }
    return "Unowned";
  }
  
  public void display(){
    fill(_color);
    rectMode(CENTER);
    if(xcor == 0 && ycor != 0 && ycor != 10){
       rect(oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
    }
    if(xcor == 10 && ycor != 0 && ycor != 10){
       rect(boardWidth-oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
    }
    if(ycor == 0 && xcor != 0 && xcor != 10){
       rect(oneSide/2 + oneSide*xcor, oneSide*7/8, oneSide, oneSide/4);
    }
    if(ycor == 10 && xcor != 0 && xcor != 10){
       rect(oneSide/2 + oneSide*xcor, height-oneSide*7/8, oneSide, oneSide/4); 
    }
    rectMode(CORNER);
    fill(0);
    text(name, oneSide*xcor, oneSide*ycor+oneSide/2);
    if (value != 0) {
      if (ownerID == -1) {
        text("$" + value, oneSide*xcor+oneSide/4, oneSide*ycor+oneSide*3/4);
      } else {
        text("$" + "WIP rent", oneSide*xcor+oneSide/4, oneSide*ycor+oneSide*3/4); //i'm trying to make it displahh who's property that is
      }
    }
  }
  
  int getCost() { //basically the buy property function
    if (ownerID == -1) {
      ownerID = turn;
      getCurrentPlayer().addProperty(this);
      return value;
    } else {
      System.out.println("WIP");
      return 50;
    }
  }
  
  
  
  void action(){
     println("Action!!!"); 
  }
  
  public String toString(){
    return xcor +","+ycor+",$"+value+","+name+",\n"+des+",\n"+ownerID+",\n"+_color+",\n"+specialProp; 
  }
}
