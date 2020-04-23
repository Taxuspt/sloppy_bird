import java.util.Random;

class Environment{
  
  Pipe[] pipes;
  Bird bird;
  Random r;
  
  int p = 3; // Number of pipes 
  int d = width / p; // Distance between them
  int hh = 100;
  int h_min = 20; // Min height of hole
  int h_max = height-80; // Max height of hole
  
  Environment(){
    r = new Random();
    setup();
  }
  
  void setup(){
    pipes = new Pipe[p];
    for(int i=0; i<pipes.length; i++){
      addPipe(i, width+d*i);
    }
    bird = new Bird();  
  }
  
  void reset(){
    setup();
  }
  
  void addPipe(int i, int d){
      int yy = r.nextInt((h_max - h_min) + 1) + h_min;
      pipes[i] = new Pipe(d, 40, yy, hh);
  }
  
  
  int lastPipeX(){
    int maxX = 0;
    for(int j=0; j<pipes.length; j++){
      int thisMax = pipes[j].getRight();
      maxX = (maxX < thisMax) ? thisMax : maxX;
    }
    return maxX;
  }
  
  void draw(){
    for(int i=0; i<pipes.length; i++){
      if(pipes[i].gone()){
        addPipe(i, lastPipeX()+d);
      }
      pipes[i].draw();
    }
    bird.draw();
    for(int i=0; i<pipes.length; i++){
      if(pipes[i].colision((int)bird.getX(), (int)bird.getY())) bird.active = false;
    }
  }

}
