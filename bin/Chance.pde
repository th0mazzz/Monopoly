public class Chance {
  Arraylist<String> cards;
  
  public Chance() {
     try {
      int counter = 0;
      BufferedReader reader = createReader("properties.txt");
      String line = reader.readLine();
      while (line != null) {
        cards.add(line);
        line = reader.readLine();
      }
    
    } catch(IOException e) {
      System.out.println("Something's wrong");
    }
  }

  void suffle() {
    
  }
  
  void action() {
  
  }
}
