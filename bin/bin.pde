import java.io.*; //<>// //<>//
import javax.swing.JOptionPane;

final int boardWidth = height;
final int oneSide = height/11;

Board board;
ArrayList<Player> players;
Dice dice;
Property[] props = new Property[40];
Chance chanceCards;
Chest chestCards;
History history;

String[] inputNames = {"Adam", "Blake", "Carol", "Daniel"};
int numPlayers = 4;
int turn;
int numRolled;

void setup() { //other sizes you can use: [550 x 385], [2200 x 1540], [3300, 2310]
  size(1100, 770); //use some multiple of 1100 x 770 cause the ratio width:height (10:7) should be kept
  background(204, 255, 245);

  board = new Board();
  dice = new Dice();
  turn = 0;
  players = new ArrayList<Player>();
  chanceCards = new Chance();
  chestCards = new Chest();
  history = new History();

  for (int i = 0; i < numPlayers; i++) {
    players.add(new Player(inputNames[i], i));
  }

  try {
    int counter = 0;
    BufferedReader reader = createReader("properties.txt");
    String line = reader.readLine();
    BufferedReader priceReader = createReader("prices.txt");
    String priceLine = priceReader.readLine();
    while (line != null) {
      //System.out.println(line);
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
    //System.out.println("the height is " + height);
    //System.out.println("but the boardWidth is " + boardWidth); //something is off
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
  fill(204, 255, 245);
  noStroke();
  rect(height/11, height/11, height/22, height*9/11);
  fill(204, 255, 245);
  stroke(0);
  rect(width*7/11+height/11, 0, width*4/11, height/2);
  for (Property prop : props) {
    prop.display();
  }
  for (Player player : players) {
    player.display(); 
    //System.out.println(printPlayers());
  }
  fill(0, 0, 0);
  rect(width*7/11+height/11, height/2, width*4/11, height/2); //"clears" history
  fill(255);
  textSize(20);
  text("History", height + 2.5*(width - height)/6, height*27/50);
  textSize(11);
  history.display();
  fill(204,255,245);
  noStroke();
  rect(height+2, 0, width-height, height/22);
  fill(0);
  textSize(20);
  text("Turn: " + getCurrentPlayer().getName(), (height+width)/3 + height/4, height/22);
  stroke(0);
  textSize(11);
  //printArray(history.history.peek());
}

void mouseClicked() { //<>//
    if(mouseX>height/11 && mouseX<width*7/11 && mouseY>height/11 && mouseY<height*10/11){
    if (turn >= players.size()) {
      turn = 0;
    }
    numRolled = dice.roll();
    getCurrentPlayer().move(numRolled);
    //getCurrentPlayer().printProperties();
     turn++;    
  }else{
   if(mouseX>0 && mouseX<oneSide || mouseX>10*oneSide && mouseX<height || mouseY>0 && mouseY<oneSide || mouseY>oneSide*10 && mouseY<height){
      int mx = mouseX / (height/11);
      int my = mouseY / (height/11);
      int propNum = -1;
      int index = 0;
      for(Property p : props){
        if(p.getXcor() == mx && p.getYcor() == my){
         propNum = index;
        }
        index++;
      }
      if(propNum != -1){
          String[] choices = {"Build House", "Sell House", "Mortgage", "Unmortgage"};
          int response = JOptionPane.showOptionDialog(null, "What would you like to do with "+props[propNum].getName()+"?", props[propNum].getName(), 
            JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, choices, choices[0]);
         //build and stuff here
         if(response == 0 && turn == props[propNum].getOwnerID() && !props[propNum].getSpecialStatus() /*&& getCurrentPlayer().checkMono(props[propNum])*/){ //rm checkMono for demo purposes 
            getCurrentPlayer().buildHouse(props[propNum]); 
         }
         if(response == 1 && turn == props[propNum].getOwnerID() && !props[propNum].getSpecialStatus()){
            getCurrentPlayer().sellHouse(props[propNum]); 
         }
         //MORTGAGE AND UNMORTGAGE!!!
      }
   }
  }
  //<>//
}

void checkTile(int num) {
  //System.out.println(props[num]);
  history.add(new HistoryText(players.get(turn)+" landed on "+props[num].getName(), height*24/25));
  if (!props[num].getSpecialStatus() || num == 5 || num == 15 || num == 25 || num == 35 || num == 12 || num == 28) {
    if (props[num].getOwnerID() == -1) {
      String[] choices = {"Buy", "Auction"};
      int response = JOptionPane.showOptionDialog(null, players.get(turn) + ",\nWould you like to buy "+props[num].getName()+" for $"+props[num].getValue()+" or auction it?\n"+
        "(Closing this window defaults to auction.)\n", props[num].getName(), 
        JOptionPane.DEFAULT_OPTION, JOptionPane.PLAIN_MESSAGE, null, choices, choices[0]);
      if (response == 0) {
        getCurrentPlayer().changeMoney(-props[num].getCost());
        fill(0);
        history.add(new HistoryText(players.get(turn)+" has purchased "+props[num].getName()+" for $" + props[num].getValue(), height*24/25));
      }
      int highestBid = 0;
      if (response == 1 || response == JOptionPane.CLOSED_OPTION) {
        boolean[] inAuction = new boolean[numPlayers];
        for (int i = 0; i < numPlayers; i++) {
          inAuction[i] = true;
        }
        int numInAuc = numPlayers;
        int aucTurn = turn;
        while (numInAuc > 1) {
          //println("aucTurn " + aucTurn);
          //println("numInAuc " + numInAuc);
          if (inAuction[aucTurn]) {
            String aucResponse = JOptionPane.showInputDialog(null, players.get(aucTurn).getName()+", what is your bid? Press cancel to forfeit   auction.\n"+
              "(Entering a non-integer value will result in automatic forfeiture of the auction.)\n"+
              "(Entering in a bid you cannot afford will result in automatic forfeiture.)\n"+
              "(Entering in a bid less than the highest bid will result in automatic forfeiture.)\n"+
              "(Closing this window results in automatic forfeiture."+"\n\nHighest Bid: "+highestBid, 
              "Auction!", JOptionPane.PLAIN_MESSAGE);
            if (aucResponse == null) { //if you close the window
              JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because "+players.get(aucTurn)+" \nclosed the window.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
              inAuction[aucTurn] = false; 
              numInAuc--;
            } else {
              try {
                int bid = Integer.parseInt(aucResponse);
                if (bid <= highestBid) {
                  JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because the bid was too little.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
                  inAuction[aucTurn] = false; 
                  numInAuc--;
                } else {
                  if (bid > players.get(aucTurn).getMoney()) {
                    JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because "+players.get(aucTurn)+" cannot\nafford the bid.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
                    inAuction[aucTurn] = false; 
                    numInAuc--;
                  } else {
                    highestBid = bid;
                  }
                }
              }
              catch(NumberFormatException e) {
                JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has forfeited the auction because a non-integer value was entered.", "Forfeit Auction", JOptionPane.INFORMATION_MESSAGE);
                inAuction[aucTurn] = false;
                numInAuc--;
              }
            }
          }  

          aucTurn++;
          if (aucTurn >= numPlayers) {
            aucTurn = 0;
          }
        }
        //println("aucTurn: " + aucTurn);
        //println("numInAuc: " + numInAuc);
        history.add(new HistoryText(players.get(turn)+" won the auction for "+ props[num].getName() +" with $"+highestBid, height*24/25));
        JOptionPane.showMessageDialog(null, players.get(aucTurn) + " has won the auction with $" + highestBid, "Auction Winner!", JOptionPane.INFORMATION_MESSAGE);
        getCurrentPlayer().changeMoney(-highestBid);
        props[num].getCost();
      }
    }else{ //if owned
      if(props[num].getOwnerID() != turn){
        if(num != 5 && num!= 15 && num!=25 && num!=35 && num!=12 && num!=28){ //if not RR or utilities
          int transaction = players.get(turn).payRent();
          history.add(new HistoryText(players.get(turn)+" paid $"+transaction+" to "+props[num].getOwnerName(), height*24/25));
        }else{
          if(num == 12 || num == 28){ //if utilities
            int multiplier;
            if(players.get(props[num].getOwnerID()).getUtilSize() == 1){
               multiplier = 4; 
            }else{
              multiplier = 10;
            }
            int transaction = dice.getRoll()*multiplier;
            history.add(new HistoryText(players.get(turn)+" paid $"+transaction+" to "+props[num].getOwnerName(), height*24/25));
          }else{
            int transaction = (int)(25 * pow(2, players.get(props[num].getOwnerID()).getRrSize() - 1)); //railriad
            getCurrentPlayer().changeMoney(-transaction);
            history.add(new HistoryText(players.get(turn)+" paid $"+transaction+" to "+props[num].getOwnerName(), height*24/25));
          }
        }
      }
    }
  }
  if (props[num].getName().equals("Chance")) {
    //history.add(new HistoryText(players.get(turn)+" has landed on Chance!", height*24/25));
    JOptionPane.showMessageDialog(null, players.get(turn) + " has landed on Chance!", "Chance Card!", JOptionPane.INFORMATION_MESSAGE);
    chanceCards.action();
  }
  if (props[num].getName().equals("Community Chest")) {
    //history.add(new HistoryText(players.get(turn)+" has landed on the Community Chest!", height*24/25));
    JOptionPane.showMessageDialog(null, players.get(turn) + " has landed on the Community Chest!", "Community Chest!", JOptionPane.INFORMATION_MESSAGE);
    chestCards.action();
  }
  if (num == 30) {
    history.add(new HistoryText(players.get(turn)+" went to jail!", height*24/25));
    getCurrentPlayer().move(20);
    getCurrentPlayer().goToJail();
    getCurrentPlayer().changeMoney(-200);
  }
}

Player getCurrentPlayer() {
  if(turn>=numPlayers){
     turn = 0; 
  }
  return players.get(turn);
}
