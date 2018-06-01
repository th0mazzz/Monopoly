public class Board {
  PImage background; 
  
  public Board() {
    background = loadImage("board.jpg");
  }

  public void display() {
    //image(background, 0, 0, 900, 900);
    for (int x = 0; x < width; x += width/11) {
      rect(x, 0, width/11, height/11);
      rect(x, 10*width/11, width/11, height/11);
    }
    for (int y = height/11; y < height * 10 / 11; y += height/11) {
      rect(0, y, width/11, height/11);
      rect(10*height/11, y, width/11, height/11);
    }
  }
}