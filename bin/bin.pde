import java.io.*;
import javax.swing.JOptionPane;

final int boardWidth = height;

Board board;
ArrayList<Player> players;
Dice dice;
Property[] props = new Property[40];
Chance chanceCards;
Chest chestCards;

String[] inputNames = {"Adam", "Blake", "Carol", "Daniel"};
int numPlayers = 4;
int turn;
int numRolled;

void setup() {
  size(1100, 770); //use some multiple of 1100 x 770
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
      System.out.println(line);
      String[] tok = line.split(";");
      //Property(xcor, ycor, price, name, description, red, green, blue, specialProp?
      props[counter] = new Property(Integer.parseInt(tok[0]), Integer.parseInt(tok[1]), 
        Integer.parseInt(tok[2]), tok[3], tok[4], 
        Integer.parseInt(tok[5]), 
        Integer.parseInt(tok[6]), Integer.parseInt(tok[7]),
        Boolean.parseBoolean(tok[8]));
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
    System.out.println("the height is " + height);
    System.out.println("but the boardWidth is " + boardWidth);
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
  System.out.println(boardWidth);
  System.out.println(height);
  if (turn >= players.size()) {
    turn = 0;
  }
  numRolled = dice.roll();
  getCurrentPlayer().move(numRolled);
  //getCurrentPlayer().printProperties();
  turn++;
}

void checkTile(int num) {
  System.out.println(props[num]);
  if (!props[num].getSpecialStatus()){
     if(props[num].getOwnerID() == -1){
         String[] choices = {"Buy", "Auction"};
         int response = JOptionPane.showOptionDialog(null, players.get(turn) + ",\nWould you like to buy "+props[num].getName()+" for $"+props[num].getValue()+" or auction it?\n"+
                                                     "(Closing this window defaults to auction.)\n", "Unowned property!", 
                                                  JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, choices, choices[0]);
         if(response == 0){
           getCurrentPlayer().changeMoney(-props[num].getCost());
           fill(0);
           text(players.get(turn)+" has purchased "+props[num].getName()+" for $" + props[num].getValue(), height+height/16, height*3/4);
         }
         int highestBid = 0;
         if(response == 1 || response == JOptionPane.CLOSED_OPTION){
           boolean[] inAuction = new boolean[numPlayers];
           for(int i = 0; i < numPlayers; i++){
             inAuction[i] = true; 
           }
           int numInAuc = numPlayers;
           int aucTurn = turn;
           while(numInAuc > 1){
             if(aucTurn >= numPlayers){
                aucTurn = 0;
             }  
             System.out.println("aucTurn " + aucTurn);
              if(inAuction[aucTurn]){
                 String aucResponse = JOptionPane.showInputDialog(null, players.get(aucTurn).getName()+", what is your bid? Press cancel to quit auction.\n"+
                                                                   "(Entering a non-integer value will result in automatic forfeiture of the auction.)\n"+
                                                                   "(Entering in a bid you cannot afford will result in automatic forfeiture.)\n"+
                                                                   "(Entering in a bid less than the highest bid will result in automatic forfeiture.)"+"\n\nHighest Bid: "+highestBid,
                                                                  "Auction!", JOptionPane.PLAIN_MESSAGE);
                 if(aucResponse == null){
                    inAuction[aucTurn] = false; 
                    numInAuc--;
                 }else{
                    try{
                       int bid = Integer.parseInt(aucResponse);
                       if(bid <= highestBid){
                          JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because the bid was too little.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
                       }
                       if(bid > players.get(aucTurn).getMoney()){
                          JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because "+players.get(aucTurn)+" cannot\nafford the bid.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE); 
                       }else{
                         highestBid = bid; 
                       }
                    }catch(NumberFormatException e){
                      JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because a non-integer value was entered.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
                      inAuction[aucTurn] = false;
                      numInAuc--;
                  }
                 }
                 aucTurn++;
              }
           }
         }
         getCurrentPlayer().changeMoney(-highestBid);
         props[num].getCost();
     }
  }
  if (props[num].getName().equals("Chance")) {
    JOptionPane.showMessageDialog(null, players.get(turn) + " has landed on Chance!", "Chance Card!", JOptionPane.INFORMATION_MESSAGE);
    chanceCards.action();
  }
  if (props[num].getName().equals("Community Chest")) {
    JOptionPane.showMessageDialog(null, players.get(turn) + " has landed on the Community Chest!", "Community Chest!", JOptionPane.INFORMATION_MESSAGE);
    chestCards.action();
  }
  if (num == 30) {
    getCurrentPlayer().move(20);
    getCurrentPlayer().goToJail();
    getCurrentPlayer().changeMoney(-200);
  }
}

Player getCurrentPlayer() {
   return players.get(turn); 
}
