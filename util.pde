class Coordinate {
  float x;
  float y;
  
  Coordinate(float x_, float y_){
    x = x_;
    y = y_;
  }
}

float[] doubleToFloat(double[] doubleArray){
  float[] floatArray = new float[doubleArray.length];
  for (int i = 0 ; i < doubleArray.length; i++)
  {
      floatArray[i] = (float) doubleArray[i];
  }
  return floatArray;
}

public static <T extends Comparable<T>> T getMax(T[] array){
  T maxRows = array[0];
  for(T layer: array){
    maxRows = layer.compareTo(maxRows) > 0 ? layer : maxRows; 
  }
  return maxRows;
}

public static int getMax(int[] array){
  int maxRows = array[0];
  for(int layer: array){
    maxRows = layer > maxRows ? layer : maxRows; 
  }
  return maxRows;
}

public static double getMax(double[] array){
  double maxRows = array[0];
  for(double layer: array){
    maxRows = layer > maxRows ? layer : maxRows; 
  }
  return maxRows;
}

public static double getMin(double[] array){
  double maxRows = array[0];
  for(double layer: array){
    maxRows = layer < maxRows ? layer : maxRows; 
  }
  return maxRows;
}
