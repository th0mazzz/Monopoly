Board board;
Player p;

void setup() {
  size(770, 770); 
  board = new Board();
  p = new Player();
}

void draw() {
  board.display();
}