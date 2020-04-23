int pipe_speed = 4;
  
class Pipe {
  int _x;
  int _w;
  int _hy;
  int _hh;
  
  Pipe(int x, int w, int hy, int hh){
    _x = x; // From left
    _w = w;
    _hy = hy; // Hole y
    _hh = hh; // Hole height
  }
  
  void draw(){
    if(!gone()){
      rect(_x, 0, _w, _hy, 0, 0, 10, 10);
      rect(_x, _hy + _hh, _w, height - (_hy + _hh), 10, 10, 0, 0);
      _x -= pipe_speed;    
    }
  }
  
  int getRight(){
    return _x + _w;
  }
  
  boolean gone(){
    return (_x + _w) < 0;
  }
  
  boolean colision(int x, int y){
    if((x > _x) && (x < (_x + _w))){
      if((y < _hy) || (y > (_hy + _hh))){
        return true;
      }
    }
    return false;
  }
  
}
