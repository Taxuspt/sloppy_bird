class HumanEnvironment extends Environment {
  Bird bird;
  
  HumanEnvironment(){
    super();
    bird = new Bird();
  }
  
  void draw(){
    super.draw();
    bird.draw();
    
    if(!bird.active) active = false;
    
    long currScore = bird.getScore();
    bestScore =  currScore > bestScore ? currScore : bestScore;
    textSize(32);
    text(Math.round(currScore), 50, 40);
  }
  
  void flap() {
    bird.flap(4);
  }
}
