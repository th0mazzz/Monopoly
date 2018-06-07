public class Property{
 int xcor, ycor;
 int value;
 String name, des;
 int id;
 int _color;
 
  public Property(int x, int y, int v, String nombre, String write, int num, int clr){
    xcor = x;
    ycor = y;
    value = v;
    name = nombre;
    des = write;
    _color = clr;
    id = num;
  }
  
  public void display(){
    fill(_color);
    rect(xcor, ycor, height/11, width/11);
  }
  
}
