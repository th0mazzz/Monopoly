import java.util.ArrayDeque;
public class History{
  
  final int x = height+height/16;
  final int y = height/25;
  final int capacity = 12;
  
  ArrayDeque<HistoryText> history;
  
  public History(){
    history = new ArrayDeque<HistoryText>();
  }
  
  void display(){
    for(HistoryText ht : history){
      ht.display(); 
    }
  }
  
  void add(HistoryText t){
     for(HistoryText ht : history){
        ht.setYcor(ht.getYcor() - y); 
     }
     
     history.add(t); 
     if(history.size() >= capacity){
        history.removeFirst(); 
     }
  }
  
}
