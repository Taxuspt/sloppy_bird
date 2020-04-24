import java.util.Arrays;

class AIPlayer implements Comparable<AIPlayer>{
  int id;
  boolean alive;
  
  // What the player sees
  float hDistance = 0;
  float vDistance = 0;
  float vSpeed = 0;
  
  // What the player will do next
  boolean flap = false;
    
  NeuralNetwork nn;
  Bird bird;

  @Override
  public int compareTo(AIPlayer player) {
      return (int)player.getFitness() - (int)this.getFitness();
  }

  AIPlayer(int id_){
    id = id_;
    alive = true;
    bird = new Bird(id);
    nn = new NeuralNetwork(getDefaultStruct());
  }
  
  AIPlayer(int id_, BrainStruct brain){
    id = id_;
    alive = true;
    bird = new Bird();
    nn = new NeuralNetwork(brain.structure, brain.W, brain.b);
  }
  
  // Updates the current environment 
  void refreshEnv(){
    // Update environment knowledge
    hDistance = (float)Math.abs((float)bird.getX() - (float)environment.pipeManager.getMinX());
    vDistance = (float)bird.getY() - (float)environment.pipeManager.getNextY();
    vSpeed = (float)bird.getvY();
  }
  
  void updateControls(){ 
    double[] input = new double[]{hDistance/width, vDistance/height, vSpeed/20};
    double[] output = nn.forward_prop(input);
    //if(id == 0){
    //  print(input[0]+" "+input[1]+"\n");
    //  print(output[0]+"\n");
    //}
    flap = output[0] > 0.5;
  }
  
  void applyControls(){
    if(bird.active && flap){
      bird.flap(4);
    }
  }

  double getFitness() {
    return bird.getScore();
  }
    
  void draw(){
    bird.draw();
    if(!bird.active) alive = false;
  }
  
  BrainStruct getBrain(){
    return new BrainStruct(nn.structure, nn.weights, nn.bias);
  }
  
  AIPlayer mutate(float rate){
    NeuralNetwork new_nn = nn.mutate(rate);
    return new AIPlayer(floor(random(10000)), new BrainStruct(new_nn.structure, new_nn.weights, new_nn.bias));
  }
  
  AIPlayer crossover(AIPlayer other){
    NeuralNetwork new_nn = nn.crossover(other.nn);
    return new AIPlayer(floor(random(10000)), new BrainStruct(new_nn.structure, new_nn.weights, new_nn.bias));
  }
  
  AIPlayer clone(){
    return new AIPlayer(id, new BrainStruct(nn.structure, nn.weights, nn.bias));
  }
  
}
