Board board;
Player p;

void setup() {
  size(1100, 1100);
  background(0,255,0);
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
  int l = int(random(6)+1);
  int r = int(random(6)+1);
  background(0,255,0);
  image(loadImage("dice_"+l+".png"), width/2-75, height/2-25, 50, 50);
  image(loadImage("dice_"+r+".png"), width/2+25, height/2-25, 50, 50);
  return l+r;
}
