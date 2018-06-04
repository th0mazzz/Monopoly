Board board;
Player p;

void setup() {
  size(770, 770); 
  frameRate(10);
  board = new Board();
  p = new Player();
}

void draw() {
  board.display();
  p.display();
}

void mouseClicked() {
  p.move(roll());
}

int roll() {
  return int(random(6)+1) + int(random(6)+1);
}
