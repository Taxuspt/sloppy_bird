class Background{

    Clouds clouds;   
    Ground ground;
  
    Background(){  
        ground = new Ground(height*0.8, height*0.9);
        clouds = new Clouds(3);
    }
    
    void draw(){
      ground.draw();
      clouds.draw();
    }
}
    
class Clouds {
  int _maxY = 180;
  int _minY = 60;
  Coordinate[] coordinates;
  
  Clouds(int n){
    coordinates = new Coordinate[n];
    for(int i=0; i<coordinates.length; i++){
      float yy = Math.round(random(1) * (_maxY - _minY) + _minY);
      float xx = width / coordinates.length * i + random(200);
      coordinates[i] = new Coordinate(xx, yy);
    }
  }

  void draw(){
    for(int i=0; i<coordinates.length; i++){
      pushMatrix();
      _polygon(coordinates[i].x, coordinates[i].y, 40, 15);
      _polygon(coordinates[i].x + 50, coordinates[i].y + 10, 40, 15);
      _polygon(coordinates[i].x + 20, coordinates[i].y + 10, 45, 15);
      popMatrix();
      coordinates[i].x -= .4;
      if(coordinates[i].x < -100){
        coordinates[i].x = width + 100 + random(200);
        coordinates[i].y = Math.round(random(1) * (_maxY - _minY) + _minY);
      }
    }
  }
  
  void _polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    fill(255,255,255);
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}

class Ground{
  int total = 30; // Vertices on the ground
  
  ArrayList<Coordinate> ground;
  
  float minY;
  float maxY;
  
  Ground(float _minY, float _maxY){
    minY = _minY;
    maxY = _maxY;
    ground = new ArrayList<Coordinate>();
    
    float padX = width / total;
    float padY = 30;
    float startX = 0;
    float startY = height * 0.8;
    
    ground.add(new Coordinate(startX, startY));
    
    for(int i=0; i<total; i++){
        float rdm = (float)Math.floor(padY * Math.random());
        if(rdm % 2 == 0) rdm *= -1;
        float x = padX * (i+1);
        float y = startY + rdm;
        if(y < minY){y = minY;};
        if(maxY < y) y = maxY;
        ground.add(new Coordinate(x, y));
        startY = y;
    }
  }
  
  void draw(){
    fill(20, 128, 20);
    stroke(255, 255, 255);
    beginShape();
    for(int i=0; i<ground.size(); i++){
      vertex(ground.get(i).x,ground.get(i).y);
    }
    vertex(width, minY);
    vertex(width, height);
    vertex(0, height);
    endShape();
    noFill();
  }
}
