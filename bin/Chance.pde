public class Chance {
  ArrayList<String> cards, deck;

  public Chance() {
     cards = new ArrayList<String>();
     deck = new ArrayList<String>();
     try {
      BufferedReader reader = createReader("chance.txt");
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
    ArrayList<String> temp = new ArrayList<String>();
    for (int index = 0; index < cards.size(); index++) {
      temp.add(cards.get(index));
    }
    if (deck.isEmpty()) {
      while (!temp.isEmpty()) {
        deck.add(temp.remove(int(random(temp.size()))));
      }
    }
  }
  
  void action() {
    int id = drawCard();
    id = 4;
    System.out.println(cards.get(id));
    if (id == 0) {
      players.get(turn).move(40-players.get(turn).getCurrentTile()); 
    }
    if (id == 1) {
      int num = 24-players.get(turn).getCurrentTile();
      if (num < 0) {
        num+= 40;
      }
      players.get(turn).move(num); 
    }
    if (id == 2) {
      int num = 11-players.get(turn).getCurrentTile();
      if (num < 0) {
        num+= 40;
      }
      players.get(turn).move(num); 
    } 
    if (id == 3) {
      int num1 = 12-players.get(turn).getCurrentTile();
      int num2 = 28-players.get(turn).getCurrentTile();
      if (num1 < 0) {
        num1+= 40;
      }
      if (num2 < 0) {
        num2+= 40;
      }
      players.get(turn).move(min(num1,num2)); 
    }
    if (id == 4) {
      int num1 = 5-players.get(turn).getCurrentTile();
      int num2 = 15-players.get(turn).getCurrentTile();
      int num3 = 25-players.get(turn).getCurrentTile();
      int num4 = 35-players.get(turn).getCurrentTile();
      if (num1 < 0) {
        num1+= 40;
      }
      if (num2 < 0) {
        num2+= 40;
      }
      if (num3 < 0) {
        num1+= 40;
      }
      if (num4 < 0) {
        num2+= 40;
      }
      players.get(turn).move(min(min(num1,num2),min(num3,num4))); 
    }
  }
  
  int drawCard() {
   return cards.indexOf(deck.remove(0)); 
  }
}
