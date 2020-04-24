class Splash {
  void draw(){
    background(50, 150, 50);
    fill(255); noStroke();
    textSize(32); textAlign(CENTER);
    text("Press H to play manually!" , width*0.5, height*0.3);
    text("Press T to train a population!" , width*0.5, height*0.3 + 40);
    text("Press B to play the best AI bird!" , width*0.5, height*0.3 + 80);
    text("Highest score: "+ bestScore , width*0.5, height*0.9);
  }
}
