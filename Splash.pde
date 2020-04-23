class Splash {
  void draw(){
    background(50, 150, 50);
    fill(255); noStroke();
    textSize(32); textAlign(CENTER);
    text("Press B to start!!" , width*0.5, height*0.5);
    text("Highest score: "+ bestScore , width*0.5, height*0.7);
  }
}
