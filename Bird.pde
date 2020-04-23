final float GRAVITY = 0.2;
final int birdColor = color(255, 255, 0);

class Bird {
  float _x;
  float _y;
  float _vY;
  boolean active;
  int score = 0;
  
  Bird() {
    active = true;
    _x = width / 10;
    _y = height / 2;
    _vY = 0;
  }
  
  float getY(){
    return _y;
  }
  
  float getX(){
    return _x;
  }
  
  void flap(float i){
    _vY -= i;
  }
  
  void draw(){
    if(active){
      _y += _vY;
      _vY += GRAVITY;
      if(_y < 0){
        _y = 0;
        _vY = 0;
      }
      if(_y > height){
        active = false;
      }
    }
    fill(birdColor);
    circle(_x, _y, 55);
    score += 1;
    bestScore = score > bestScore ? score : bestScore;
    textSize(32);
    text(score, 40, 40); 
  }
}
