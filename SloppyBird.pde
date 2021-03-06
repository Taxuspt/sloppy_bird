Environment environment;
Splash splash;
Background background;

int speed = 40;
boolean started = false;
long bestScore = 0;

void setup(){
  frameRate(speed);  
  size(800, 600);
  
  noFill();
  noStroke();
  
  splash = new Splash();
  background = new Background();
  print("Width is: "+ width + "\n");
  print("Height is: "+ height + "\n");
  
  //Matrix b = Matrix.random(4,2);
  //b.print(1,3);
  //for(double v: b.getColumnPackedCopy()) print(v+"; ");
  //print("\n");
  //for(double v: b.getRowPackedCopy()) print(v+"; ");
}

void draw(){
  background(0, 0, 200);
  stroke(255);
  fill(255);
  
  background.draw();
  
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
        selectInput("Select a file to process:", "fileSelected");
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

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    environment = new AIEnvironment(loadBrainStruct(selection.getAbsolutePath()));
    started = true;
  }
}

void gameOver(){
    background(100, 50, 50);
    fill(255); noStroke();
    textSize(32); textAlign(CENTER);
    text("GAME OVER!!" , width*0.5, height*0.5);
    started = false;
}
