  public class Dice{
  int l;
  int r;
  
  public Dice(){
   //nothing!    
  }
  
  int roll() {
    l = int(random(6)+1);
    r = int(random(6)+1);
    fill(204,255,245);
    noStroke();
    rect(width/2-75, height/2-25,50,50);
    rect(width/2+25, height/2-25,50,50);
    stroke(0);
    image(loadImage("dice_"+l+".png"), width/2-75, height/2-25, 50, 50);
    image(loadImage("dice_"+r+".png"), width/2+25, height/2-25, 50, 50);
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
  
}
