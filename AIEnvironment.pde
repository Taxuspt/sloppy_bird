class AIEnvironment extends Environment {
  AIPlayer player;
  
  AIEnvironment(BrainStruct struct){
    super();
    player = new AIPlayer(0, struct);
  }
  
  void draw(){
    super.draw();
    if(!player.alive) active=false;
    player.refreshEnv();
    player.updateControls();
    player.applyControls();        
    player.draw();
    
    long currScore = (long)player.getFitness();
    bestScore =  currScore > bestScore ? currScore : bestScore;
    textSize(32);
    text(Math.round(currScore), 50, 40);
  }
}
