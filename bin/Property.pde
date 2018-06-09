public class Property{
 final int boardWidth = height;
 final int oneSide = boardWidth / 11; //for 770x770, this is 77
  
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
  
  public void setBaseRent(int num){baseRent = num;}
  public void setRentOne(int num){rentOne = num;}
  public void setRentTwo(int num){rentTwo = num;}
  public void setRentThree(int num){rentThree = num;}
  public void setRentFour(int num){rentFour = num;}
  public void setRentHotel(int num){rentHotel = num;}
  public void setMortPrice(int num){mortPrice = num;}
  public void setBuildingPrice(int num){buildingPrice = num;}
  
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
  
  int getCost() {
    if (ownerID == -1) {
      ownerID = turn;
      getCurrentPlayer().addProperty(this);
      return value;
    } else {
      System.out.println("WIP");
      return 50;
    }
  }
  
  boolean getSpecialStatus(){
     return specialProp; 
  }
  
  int getOwnerID(){
     return ownerID; 
  }
  
  String getName() {
    return name;
  }
  
  public String toString(){
    return xcor +","+ycor+",$"+value+","+name+",\n"+des+",\n"+ownerID+",\n"+_color+",\n"+specialProp; 
  }
}
