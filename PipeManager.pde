import java.util.Random;

class PipeManager {
  
  Pipe[] pipes;
  
  int p = 3; // Number of pipes 
  int d = width / p; // Distance between them (them = the pipes)
  int hh = 180; // Hole height (the actual hole the bird goes through)
  int h_min = 20; // Min height of hole (distance from ceiling)
  int h_max = height-240; // Max height of hole (distance from floor)
  
  Random r;
  
  PipeManager() {
    r = new Random();
    setup();
  }
  
  void setup(){
    pipes = new Pipe[p];
    for(int i=0; i<pipes.length; i++){
      addPipe(i, width+d*i);
    }
  }
  
  void reset(){
    setup();
  }
  
  void draw() {
    for(int i=0; i<pipes.length; i++){
      if(pipes[i].gone()){
        addPipe(i, getMaxX()+d);
      }
      pipes[i].draw();
    }
  }
    
  void addPipe(int i, int d){
      int yy = r.nextInt((h_max - h_min) + 1) + h_min;
      pipes[i] = new Pipe(d, 40, yy, hh);
  }
   
  int getMaxX(){
    int maxX = 0;
    for(int j=0; j<pipes.length; j++){
      int thisMax = pipes[j].getRight();
      maxX = (maxX < thisMax) ? thisMax : maxX;
    }
    return maxX;
  }
  
  int getMinX(){
    int minX = 10000;
    for(int j=0; j<pipes.length; j++){
      int thisMin = pipes[j].getLeft();
      minX = (minX < thisMin) ? minX : thisMin;
    }
    return minX;
  }
  
  int getNextY(){
    int nextY = 0;
    int minX = 10000;
    int thisX;
    for(int j=0; j<pipes.length; j++){
      thisX = pipes[j].getLeft();
      if(thisX < minX){
        nextY = pipes[j].getHy();
        minX = thisX;
      }      
    }
    return nextY;
  }
  
  boolean colision(float x, float y){
    for(int i=0; i<pipes.length; i++){
      if(pipes[i].colision(x, y)) return true;
    }
    return false;
  }
  
}
