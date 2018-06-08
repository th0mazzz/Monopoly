public class Chest {
  ArrayList<String> cards, deck;

  public Chance() {
     cards = new ArrayList<String>();
     deck = new ArrayList<String>();
     try {
      BufferedReader reader = createReader("chest.txt");
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
    if (id == 0) {
      getCurrentPlayer().move(40-getCurrentPlayer().getCurrentTile()); 
    }
    if (id == 1) {
     getCurrentPlayer().changeMoney(200); 
    }
    if (id == 2) {
      getCurrentPlayer().changeMoney(-50);
    }
    if (id == 3) {
      getCurrentPlayer().changeMoney(50);
    }
    if (id == 4) {
      getCurrentPlayer().getJailCard();
    }
    if (id == 5) {
      if (id == 8) {
      int num = 10-getCurrentPlayer().getCurrentTile();
      if (num < 0) {
        num+= 40;
      }
      if (num > 3) {
        getCurrentPlayer().changeMoney(-200);
      }
      getCurrentPlayer().goToJail(); 
      getCurrentPlayer().move(num); 
    }
    if (id == 6) {
      for (Player p : players) {
        p.changeMoney(-50);
      }
      getCurrentPlayer().changeMoney(50*players.size());
    }
    if (id == 7) {
      getCurrentPlayer().changeMoney(100);
    }
    if (id == 8) {
      getCurrentPlayer().changeMoney(20);
    }
    if (id == 9) {
      getCurrentPlayer().changeMoney(100);
    }
    if (id == 10) {
      getCurrentPlayer().changeMoney(-100);
    }
    if (id == 11) {
      getCurrentPlayer().changeMoney(-150);
    }
    if (id == 12) {
      getCurrentPlayer().changeMoney(25);
    }
    if (id == 13) {
      
    }
    if (id == 14) {
      getCurrentPlayer().changeMoney(10);
    }
    if (id == 15) {
      getCurrentPlayer().changeMoney(100);
    }
  }
  
  int drawCard() {
    if (deck.isEmpty()) {
      shuffle();
    }
   return cards.indexOf(deck.remove(0)); 
  }
}
