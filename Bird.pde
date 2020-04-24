final float GRAVITY = 0.2;

class Bird {
  float _x;
  float _y;
  float _vY;
  boolean active;
  long _score = 0;
  int _id;

  int birdColor = color(255, 255, 0);
  int textColor;
  
  PImage bird = loadImage("bird.png");
  PImage bird_up = loadImage("bird_up.png");
  PImage bird_down = loadImage("bird_down.png");
  
  Bird() {
    _setup((int)random(255));
  }
  
  Bird(int id){
    _setup(id);
  }
  
  void _setup(int id){
    _id = id;
    active = true;
    _x = width / 10;
    _y = height / 2;
    _vY = 0;
    textColor = color((int)random(255), (int)random(255), (int)random(255));
  }
    
  float getY(){
    return _y;
  }
  
  float getvY(){
    return _vY;
  }
  
  float getX(){
    return _x;
  }
  
  void flap(int i){
    _vY -= i;
  }
  
  long getScore(){
    return _score;
  }
  
  void draw(){
    _y += _vY;
    _vY += GRAVITY;
    if(_y < 0){//{_y = 0; _vY = 0;}
      active = false;
      return;
    }
    if(_y > height){
      active = false;
      return;
    }
    if(environment.pipeManager.colision(_x, _y)){
      active = false;
      return;
    }

    //fill(birdColor);
    //circle(_x, _y, 55);
    pushMatrix();
    translate(-30, -30);
    if(_vY > 0 ){
      image(bird_down, _x, _y, 70, 60);
    }else if(_vY <= 0 ){
      image(bird_up, _x, _y, 70, 60);
    } else {
      image(bird, _x, _y, 70, 60);
    }
    popMatrix();
    
    _score += 1;
    
    //textSize(16); 
    //textAlign(CENTER);
    //fill(0);
    //text(_id, _x, _y);
  }
}
