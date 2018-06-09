public class Board {
  PImage background; 
  final int boardWidth = height;
  
  public Board() {
    background = loadImage("board.jpg");
  }

  public void display() {
    //image(background, 0, 0, 900, 900);
    fill(255);
    for (int x = 0; x < boardWidth; x += boardWidth/11) {
      rect(x, 0, boardWidth/11, height/11);
      rect(x, 10*boardWidth/11, boardWidth/11, height/11);
    }
    for (int y = height/11; y < height * 10 / 11; y += height/11) {
      rect(0, y, boardWidth/11, height/11);
      rect(10*height/11, y, boardWidth/11, height/11);
    }
  }
}
