class Coordinate {
  float x;
  float y;
  
  Coordinate(float x_, float y_){
    x = x_;
    y = y_;
  }
}

static float[] doubleToFloat(double[] doubleArray){
  float[] floatArray = new float[doubleArray.length];
  for (int i = 0 ; i < doubleArray.length; i++)
  {
      floatArray[i] = (float) doubleArray[i];
  }
  return floatArray;
}
