class NaturalSelectionEnvironment extends Environment {
  Population population;
  
  NaturalSelectionEnvironment(){
    super();
    population = new Population(20);
  }
  
  void draw(){
    super.draw();
    if(!population.allCrashed()){
      population.update();
    } else {
      population.evolve();
      pipeManager.reset();
    }
  }
}
