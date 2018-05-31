public class Board {
  PImage background; 
  Tile[] tiles;

  public Board() {
    background = loadImage("board.jpg");
    tiles = new Tile[40]; //one possible way to keep track of tiles
  }

  public void display() {
    image(background, 0, 0, 900, 900);
  }
}
