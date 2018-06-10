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
    //System.out.println(id);
    //System.out.println(cards.get(id));
    JOptionPane.showMessageDialog(null, cards.get(id), "Chance Card!", JOptionPane.INFORMATION_MESSAGE);
    if (id == 0) {
      getCurrentPlayer().move(40-getCurrentPlayer().getCurrentTile()); 
    }
    if (id == 1) {
      int num = 24-getCurrentPlayer().getCurrentTile();
      if (num < 0) {
        num+= 40;
      }
      getCurrentPlayer().move(num); 
    }
    if (id == 2) {
      int num = 11-getCurrentPlayer().getCurrentTile();
      if (num < 0) {
        num+= 40;
      }
      getCurrentPlayer().move(num); 
    } 
    if (id == 3) {
      int num1 = 12-getCurrentPlayer().getCurrentTile();
      int num2 = 28-getCurrentPlayer().getCurrentTile();
      if (num1 < 0) {
        num1+= 40;
      }
      if (num2 < 0) {
        num2+= 40;
      }
      getCurrentPlayer().move(min(num1,num2)); 
    }
    if (id == 4) {
      int num1 = 5-getCurrentPlayer().getCurrentTile();
      int num2 = 15-getCurrentPlayer().getCurrentTile();
      int num3 = 25-getCurrentPlayer().getCurrentTile();
      int num4 = 35-getCurrentPlayer().getCurrentTile();
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
      getCurrentPlayer().move(min(min(num1,num2),min(num3,num4))); 
    }
    if (id == 5) {
      getCurrentPlayer().changeMoney(50);
    }
    if (id == 6) {
      getCurrentPlayer().getJailCard();
    }
    if (id == 7) {
      getCurrentPlayer().move(37);
      getCurrentPlayer().changeMoney(-200);
    }
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
    if (id == 9) {
      /*         System.out.println("Houses and hotels are WIP");      */
      //getCurrentPlayer().changeMoney(-100*hotel-25*house);
    }
    if (id == 10) {
      getCurrentPlayer().changeMoney(-15);
    }
    if (id == 11) {
      getCurrentPlayer().move(5-getCurrentPlayer().getCurrentTile()); 
    }
    if (id == 12) {
      getCurrentPlayer().move(39-getCurrentPlayer().getCurrentTile()); 
    }
    if (id == 13) {
      for (Player p : players) {
        p.changeMoney(50);
      }
      getCurrentPlayer().changeMoney(-50*players.size());
    }
    if (id == 14) {
      getCurrentPlayer().changeMoney(150);
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
