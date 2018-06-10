public class HistoryText{
  final int x = height+height/16;
  final int y = height*24/25;
  
  int xcor, ycor;
  String message;
  
 public HistoryText(String message, int ycor){
   this.message = message;
   this.ycor = ycor;
 }
  
  void setXcor(int x){xcor = x;}
  void setYcor(int y){ycor = y;}
  void setMessage(String m){message = m;}
  
  int getXcor(){return xcor;}
  int getYcor(){return ycor;}
  String getMessage(){return message;}
  
  void display(){
    text(message, x, ycor);
  }
  
  String toString(){
      return message;
  }
  
}
