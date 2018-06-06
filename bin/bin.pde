Board board;
Player[] players;
Dice dice;
//Property[] props;

String[] inputNames = {"Adam", "Blake", "Carol", "Daniel"};
int numPlayers = 4;
int turn;

void setup() {
  size(770, 770);
  background(0, 255, 0);

  board = new Board();
  dice = new Dice();
  turn = 0;
  players = new Player[numPlayers];
  for (int i = 0; i < numPlayers; i++) {
    players[i] = new Player(inputNames[i]);
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