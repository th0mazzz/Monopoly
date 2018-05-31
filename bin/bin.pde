Board board;

void setup() {
  size(900, 900); 
  board = new Board();
}

void draw() {
  board.display();
}
