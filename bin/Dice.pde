  public class Dice{
  int l;
  int r;
  final int offset = width - height;
  public Dice(){
   //nothing!    
  }
  
  int roll() {
    l = int(random(6)+1);
    r = int(random(6)+1);
    //l = r;
    fill(204,255,245);
    noStroke();
    rect((width-offset)/2-75, height/2-25,50,50);
    rect((width-offset)/2+25, height/2-25,50,50);
    stroke(0);
    System.out.println(offset);
    image(loadImage("dice_"+l+".png"), (width-offset)/2-75, height/2-25, 50, 50);
    image(loadImage("dice_"+r+".png"), (width-offset)/2+25, height/2-25, 50, 50);
    history.add(new HistoryText(players.get(turn)+" has rolled a " + (l+r), height*24/25));
    if (l == r) {
      sameNum = true;
    }
    return l+r;
    //Testing chance/community
    /*
    int num = 2-getCurrentPlayer().getCurrentTile();
    if (num < 0) {
      num+= 40;
    }
    return num;
    */
  }
  
  int getRoll(){return l+r;}
  
}
