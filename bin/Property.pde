public class Property{
 final int oneSide = width / 11; //for 770x770, this is 77
  
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
                  int red, int green, int blue){
    xcor = x;
    ycor = y;
    value = v;
    name = nombre;
    des = write;
    _color = color(red,green,blue);
    ownerID = -1; //-1 means bank's (not owned by player yet)
    isMort = false;
  }
  
  public void display(){
    fill(_color);
    rectMode(CENTER);
    if(xcor == 0 && ycor != 0 && ycor != 10){
       rect(oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
    }
    if(xcor == 10 && ycor != 0 && ycor != 10){
       rect(width-oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
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
  }
  
  int getCost() {
    return value;
  }
  
  public String toString(){
    return xcor +","+ycor+",$"+value+","+name+",\n"+des+",\n"+ownerID+",\n"+_color; 
  }
}
