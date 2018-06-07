public class Property{
 int xcor, ycor;
 int value;
 String des;
 int id;
 int _color;
 
  public Property(int x, int y, int v, String write, int num, int clr){
    xcor = x;
    ycor = y;
    value = v;
    des = write;
    _color = clr;
  }
  
  public void display(){
    fill(_color);
    rect(xcor, ycor, height/11, width/11);
  }
  
}
