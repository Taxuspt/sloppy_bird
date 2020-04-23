int speed = 30;

Environment environment;
Splash splash;

boolean started = false;
int bestScore = 0;

void setup(){
  frameRate(speed);  
  size(800, 600);
  
  noFill();
  noStroke();
  
  environment = new Environment();
  splash = new Splash();
}

void draw(){
  background(0, 0, 0);

  stroke(255);
  fill(255);
  
  if(started){
    if(!environment.bird.active) gameOver();
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
        environment.bird.flap(4);
        break;
      case 'b': // start game
        print('b');
        if(!environment.bird.active) environment.reset();
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
