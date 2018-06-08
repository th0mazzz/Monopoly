public class Chance {
  ArrayList<String> cards, deck;

  public Chance() {
     cards = new ArrayList<String>();
     deck = new ArrayList<String>();
     try {
      BufferedReader reader = createReader("properties.txt");
      String line = reader.readLine();
      while (line != null) {
        cards.add(line);
        line = reader.readLine();
      }
    
    } catch(IOException e) {
      System.out.println("Something's wrong");
    }
    
    shuffle();
  }

  void shuffle() {
    if (deck.isEmpty()) {
      while (!cards.isEmpty()) {
        deck.add(cards.remove(int(random(cards.size()))));
      }
    }
  }
  
  void action() {
    
  }
}
