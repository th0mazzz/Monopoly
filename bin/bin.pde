import java.io.*;
import javax.swing.JOptionPane;

Board board;
ArrayList<Player> players;
Dice dice;
Property[] props = new Property[40];
Chance chanceCards;
Chest chestCards;

String[] inputNames = {"Adam", "Blake", "Carol", "Daniel"};
int numPlayers = 4;
int turn;

void setup() {
  size(1100, 770);
  background(204, 255, 245);

  board = new Board();
  dice = new Dice();
  turn = 0;
  players = new ArrayList<Player>();
  chanceCards = new Chance();
  chestCards = new Chest();
  
  for (int i = 0; i < numPlayers; i++) {
    players.add(new Player(inputNames[i],i));
  }
  
  try {
    int counter = 0;
    BufferedReader reader = createReader("properties.txt");
    String line = reader.readLine();
    BufferedReader priceReader = createReader("prices.txt");
    String priceLine = priceReader.readLine();
    while (line != null) {
      String[] tok = line.split(";");
      //Property(xcor, ycor, price, name, description, ownerID, color
      props[counter] = new Property(Integer.parseInt(tok[0]), Integer.parseInt(tok[1]), 
        Integer.parseInt(tok[2]), tok[3], tok[4], 
        Integer.parseInt(tok[5]), 
        Integer.parseInt(tok[6]), Integer.parseInt(tok[7]));
        line = reader.readLine();
        //price line reader thing here
        String[] priceTok = priceLine.split(";");
        props[counter].setBaseRent(Integer.parseInt(priceTok[0]));
        props[counter].setRentOne(Integer.parseInt(priceTok[1]));
        props[counter].setRentTwo(Integer.parseInt(priceTok[2]));
        props[counter].setRentThree(Integer.parseInt(priceTok[3]));
        props[counter].setRentFour(Integer.parseInt(priceTok[4]));
        props[counter].setMortPrice(Integer.parseInt(priceTok[5]));
        props[counter].setBuildingPrice(Integer.parseInt(priceTok[6]));
        priceLine = priceReader.readLine();
        counter++;
    }
    
  }
  catch(IOException e) {
    System.out.println("Something's wrong");
  }
  
  //OUTPUT CODE TO SEE
  //System.out.println(printProps());
  //END
}

String printPlayers() {
  String returnString = "";
  for (Player p : players) {
    returnString = returnString + p;
  }
  return returnString;
}

String printProps() {
  String returnString = "";
  for (Property p : props) {
    returnString = returnString + p + "\n\n";
  }
  return returnString;
}

void draw() {
  board.display();
  for(Property prop : props){
    prop.display(); 
  }
  for (Player player : players) {
    player.display(); 
    //System.out.println(printPlayers());
  }
}

void mouseClicked() {
  if (turn >= players.size()) {
    turn = 0;
  }
  getCurrentPlayer().move(dice.roll());
  getCurrentPlayer().printProperties();
  turn++;
}

void checkTile(int num) {
  System.out.println(props[num]);
  if (props[num].getName().equals("Chance")) {
    JOptionPane.showMessageDialog(null, players.get(turn) + " has landed on Chance!", "Chance Card!", JOptionPane.INFORMATION_MESSAGE);
    chanceCards.action();
  }
  if (props[num].getName().equals("Community Chest")) {
    chestCards.action();
  }
  if (num == 30) {
    getCurrentPlayer().move(20);
    getCurrentPlayer().goToJail();
    getCurrentPlayer().changeMoney(-200);
  }
  getCurrentPlayer().changeMoney(-props[num].getCost());
}

Player getCurrentPlayer() {
   return players.get(turn); 
}
