public class Property{
 final int oneSide = width / 11; //for 770x770, this is 77
  
 int xcor, ycor;
 int value;
 String name, des;
 int id;
 color _color;
 
  public Property(int x, int y, int v, String nombre, String write, int num, 
                  int red, int green, int blue){
    xcor = x;
    ycor = y;
    value = v;
    name = nombre;
    des = write;
    _color = color(red,green,blue);
    id = num;
  }
  
  public void display(){
    fill(_color);
    rectMode(CENTER);
    if(xcor == 0){
       rect(oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
    }
    if(xcor == 10){
       rect(width-oneSide*7/8, oneSide/2 + oneSide*ycor, oneSide/4, oneSide);
    }
    if(ycor == 0){
       rect(oneSide/2 + oneSide*xcor, oneSide*7/8, oneSide, oneSide/4);
    }
    if(ycor == 10){
       rect(oneSide/2 + oneSide*xcor, height-oneSide*7/8, oneSide, oneSide/4); 
    }
    rectMode(CORNER);
  }
  
  public String toString(){
    return xcor +","+ycor+",$"+value+","+name+",\n"+des+",\n"+id+",\n"+_color; 
  }
}
