Environment environment;
Splash splash;

int speed = 30;
boolean started = false;
long bestScore = 0;

void setup(){
  frameRate(speed);  
  size(800, 600);
  
  noFill();
  noStroke();
  
  splash = new Splash();
}

void draw(){
  background(0, 0, 0);
  stroke(255);
  fill(255);
  
  if(started){
    if(!environment.active) gameOver();
    environment.draw();  
  } else {
    splash.draw();
  }

}

void keyPressed(){
    switch(key) {
      case 'w'://speed up frame rate
        speed += 5;
        frameRate(speed);
        print("Framerate = "+ speed+"\n");
        break;
      case 's'://slow down frame rate
        if (speed > 10) {
          speed -= 5;
          frameRate(speed);
        }
        break;
      
      case 'f':// flap wings
        environment.flap();
        break;
      
      case 'b': // start ai bird
        //started = true;
        break;
      case 't': // start training game
        environment = new NaturalSelectionEnvironment();
        started = true;
        break;
      case 'h': // start human game
        environment = new HumanEnvironment();
        started = true;
        break;
    }
}

void gameOver(){
    background(100, 50, 50);
    fill(255); noStroke();
    textSize(32); textAlign(CENTER);
    text("GAME OVER!!" , width*0.5, height*0.5);
    started = false;
}
