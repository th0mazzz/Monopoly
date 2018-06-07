Board board;
import java.io.*;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

Player[] players;
Dice dice;
Property[] props;

String[] inputNames = {"Adam", "Blake", "Carol", "Daniel"};
int numPlayers = 4;
int turn;

void setup() {
  size(770, 770);
  background(204, 255, 245);

  board = new Board();
  dice = new Dice();
  turn = 0;
  players = new Player[numPlayers];
  for (int i = 0; i < numPlayers; i++) {
    players[i] = new Player(inputNames[i]);
  }
  
  try{
   String fileName = "properties.txt";
   File theProps = new File(fileName);
   Scanner in = new Scanner(theProps);
   
   while(in.hasNext()){
     int counter = 0;
     String line = in.nextLine();
     String[] tok = line.split(" ");
                            //Property(xcor, ycor, price, name, description, ownerID, color
     props[counter] = new Property(Integer.parseInt(tok[0]), Integer.parseInt(tok[1]), 
                                   Integer.parseInt(tok[2]), tok[3], tok[4], 
                                   Integer.parseInt(tok[5]), Integer.parseInt(tok[6]));
     
   }
  }catch(FileNotFoundException e){
    System.out.println("properties.txt cannot be located");
  }
}

String printPlayers() {
  String returnString = "";
  for (Player p : players) {
    returnString = returnString + p;
  }
  return returnString;
}

void draw() {
  board.display();
  for (Player player : players) {
    player.display(); 
    System.out.println(printPlayers());
  }
}

void mouseClicked() {
  if (turn >= numPlayers) {
    turn = 0;
  }
  players[turn].move(dice.roll());
  turn++;
}
