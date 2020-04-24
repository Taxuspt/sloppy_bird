import java.util.Arrays;

class Population {
  AIPlayer[] players;
  
  int gen = 1;
  double currentBestFitness = 0;
  double globalBestFitness = 0;
  float mutationRate = 0.05;
  AIPlayer currentBestPlayer;
  AIPlayer globalBestPlayer;
  
  int populationID = floor(random(10000));
  
  Population(int size) {
    players = new AIPlayer[size];
    for (int i =0; i<players.length; i++) {
      players[i] = new AIPlayer(i);
    }
  }
    
  void update(){   
    for (int i =0; i<players.length; i++) {
      if(players[i].alive){
        players[i].refreshEnv();
        players[i].updateControls();
        players[i].applyControls();        
        players[i].draw();
      }
    }
    drawStatuses();
    //drawShortStatuses();
  }
  
  int[] getTopN(int n){
    AIPlayer[] temp = players.clone();
    Arrays.sort(temp);
    //for(int i=0; i<temp.length; i++){
    //  print("#"+i+": "+temp[i].id+": "+temp[i].getFitness()+"\n");
    //}
    int[] ids = new int[n];
    for(int i=0; i<n; i++){
      for(int j=0; j<players.length; j++){
        if(temp[i].id == players[j].id){
          ids[i] = j;
          continue;
        }
       
      }
      //print("#"+i+": Pilot "+players[ids[i]].id+" has "+players[ids[i]].getFitness()+" fitness\n");
    }
    return ids;
  }
  
  void drawShortStatuses(){
    textSize(16); 
    textAlign(LEFT);
    fill(255);
    text("Global Best Fitness:" + globalBestFitness, 50, 20);
    text("Current Best Fitness:" + currentBestFitness, 50, 40);
    text("Current Gen:" + gen, 50, 60);
    text("Flap:" + players[0].flap, 50, 80);
  }
  
  void drawStatuses(){
    AIPlayer player = players[0];
    int alive = 0;
    for(int i=0; i<players.length; i++){
      if(players[i].alive){
        alive+=1;
        player = players[i];
      }
    }
    
    fill(255, 255, 255);
    noStroke();
    textSize(16); textAlign(LEFT);
    int vSpace = 20;
    
    text("Global Best Fitness:" + globalBestFitness, 50, vSpace);
    text("Current Best Fitness:" + currentBestFitness, 50, 2*vSpace);
    text("Current Fitness:" + player.getFitness(), 50, 3*vSpace);
    text("Current Gen: " + gen + " Alive: " + alive, 50, 4*vSpace);
    text("H. Distance:" + Math.round(player.hDistance), 50, 5*vSpace);
    text("V. Distance:" + Math.round(player.vDistance), 50, 6*vSpace);
    text("V. Speed:" + Math.round(player.vSpeed), 50, 7*vSpace);
  }
  
  void evolve(){
    AIPlayer[] newPlayers = new AIPlayer[players.length];
    
    //Clone get best Pilot
    currentBestPlayer = cloneBestPlayer();
    currentBestFitness = getBestFitness();
    if(currentBestFitness > globalBestFitness){
      globalBestFitness = currentBestFitness;
      globalBestPlayer = cloneBestPlayer();
    }
    
    newPlayers[0] = globalBestPlayer.clone();
    newPlayers[1] = currentBestPlayer;
    
    // Mutate the best Pilots
    newPlayers[2] = newPlayers[0].mutate(mutationRate);
    newPlayers[3] = newPlayers[1].mutate(mutationRate);
    
    // Crossover the top 3 Pilots
    int[] ids = getTopN(4);
    for(int i=4; i<players.length-3; i++){
      int p1 = (int)(Math.random()*ids.length);
      int p2 = (int)(Math.random()*ids.length);
      newPlayers[i] = players[ids[p1]].crossover(players[ids[p2]]).mutate(mutationRate);
    }
    
    for(int i=players.length-3; i<players.length; i++){
       newPlayers[i] = new AIPlayer(floor(random(10000)));
    }
    
    gen +=1;
    players = newPlayers.clone();
    if(globalBestFitness > 800) mutationRate = 0.01;
  }
  
  boolean allCrashed() {
    for (int i = 0; i< players.length; i++) {
      if (players[i].alive) {
        return false;
      }
    }
    return true;
  }
    
  double getBestFitness(){
    double bestFitness = players[0].getFitness();
    for(int i=1; i<players.length; i++){
      if(players[i].getFitness() > bestFitness){
        bestFitness = players[i].getFitness();
      }
    }
    return bestFitness;
  }
  
  AIPlayer cloneBestPlayer(){
    BrainStruct brain = players[0].getBrain();
    double bestFitness = players[0].getFitness();
    for(int i=1; i<players.length; i++){
      if(players[i].getFitness() > bestFitness){
        brain = players[i].getBrain();
        bestFitness = players[i].getFitness();
      }
    }
    return new AIPlayer(0, brain);
  }
  
}
