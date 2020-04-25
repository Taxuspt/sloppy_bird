class AIEnvironment extends Environment {
  AIPlayer player;
  NeuralActivation na;
  
  AIEnvironment(BrainStruct struct){
    super();
    player = new AIPlayer(0, struct);
    na = new NeuralActivation(player.nn);
  }
  
  void draw(){
    super.draw();
    if(!player.alive) active=false;
    player.refreshEnv();
    player.updateControls();
    player.applyControls();        
    player.draw();
    na.draw(width - 300, height - 200);
    
    long currScore = (long)player.getFitness();
    bestScore =  currScore > bestScore ? currScore : bestScore;
    textSize(32);
    fill(255);
    text(Math.round(currScore), 50, 40);
  }
}
