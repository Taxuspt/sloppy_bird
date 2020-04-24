class Environment{
  
  PipeManager pipeManager;
  
  boolean active;
  
  Environment() {
    active = true;
    pipeManager = new PipeManager();
  }
    
  void draw() {
    pipeManager.draw();
  }
  
  void flap(){
  
  }
}
