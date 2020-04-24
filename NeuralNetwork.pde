import Jama.*;

class NeuralNetwork {
  
  int[] structure;
  Matrix[] weights;
  Matrix[] bias;
  
  NeuralNetwork(int[] structure_, Matrix[] W, Matrix[] b){
    weights = W;
    bias = b;
    structure = structure_;
  }
  
  NeuralNetwork(int[] structure_) {
    
    structure = structure_;
    weights = new Matrix[structure.length-1];
    bias = new Matrix[structure.length-1];
    
    for(int i = 1; i<structure.length; i++){
      Double he = Math.sqrt(2/structure[i-1]); // He initialization
      weights[i-1] = Matrix.random(structure[i], structure[i-1]).minus(new Matrix(structure[i], structure[i-1], 0.5)).times(1);
      bias[i-1] = new Matrix(structure[i], 1, 0);
      //print("Weights "+(i-1));
      //weights[i-1].print(1, 3);
      //print("Bias "+(i-1));
      //bias[i-1].print(1, 3);
    }   
  }
  
  double[] forward_prop(double[] input_) {
    if(input_.length == structure[0]){
      Matrix input = new Matrix(input_, structure[0]);
      //print("NN input:");
      //input.print(1, 3);
      for(int i=0; i<weights.length; i++){
        Matrix a1 = weights[i].times(input);
        input = sigmoid((a1).plus(bias[i]));
        //print("NN temp "+ i);
        //input.print(1, 3);
      }
      //print("NN output:");
      //input.print(1, 3);
      return input.getColumnPackedCopy();
    } else {
      return new double[structure[-1]];
    }
  }
  
  Matrix sigmoid(Matrix input){
    int r = input.getRowDimension();
    int c = input.getColumnDimension();
    Matrix n = new Matrix(r, c);
    for(int i=0; i<r; i++){
      for(int j=0; j<c; j++){
        float v = sigmoid((float)input.get(i, j));
        n.set(i, j, v);
      }
    }
    return n;
  }
  
  float sigmoid(float x){
    return 1 / (1 + pow((float)Math.E, -x));
  }
  
  // Mutations and crossovers
  NeuralNetwork mutate(float mutationRate) {
    Matrix[] n_weights = new Matrix[weights.length];
    Matrix[] n_bias = new Matrix[bias.length];
    for(int i=0; i<weights.length; i++){
      double[] w_temp = weights[i].getColumnPackedCopy();
      double[] b_temp = bias[i].getColumnPackedCopy();
      int w_rows = weights[i].getRowDimension();
      int b_rows = bias[i].getRowDimension();
      for(int j=0; j<w_temp.length; j++){
        if (random(1) < mutationRate) w_temp[j] += randomGaussian()/5;
      }
      for(int k=0; k<b_temp.length; k++){
        if (random(1) < mutationRate) b_temp[k] += randomGaussian()/5;
      }
      n_weights[i] = new Matrix(w_temp, w_rows);
      n_bias[i] = new Matrix(b_temp, b_rows);
    }
    
    return new NeuralNetwork(structure, n_weights, n_bias);
  }
    
  NeuralNetwork crossover(NeuralNetwork other) {
    Matrix[] n_weights = new Matrix[weights.length];
    Matrix[] n_bias = new Matrix[bias.length];
    
    for(int i=0; i<weights.length; i++){
      
      int w_rows = weights[i].getRowDimension();
      int b_rows = bias[i].getRowDimension();
      
      double[] w_this = weights[i].getColumnPackedCopy();
      double[] w_other = other.weights[i].getColumnPackedCopy();
      double[] w_new = new double[w_this.length];
      for(int j=0; j<w_this.length; j++){
        w_new[j] = random(1) < 0.5 ? w_this[j] : w_other[j];
      }
      
      double[] b_this = bias[i].getColumnPackedCopy();
      double[] b_other = other.bias[i].getColumnPackedCopy();
      double[] b_new = new double[b_this.length];
      for(int k=0; k<b_this.length; k++){
        b_new[k] = random(1) < 0.5 ? b_this[k] : b_other[k];
      }
      
      n_weights[i] = new Matrix(w_new, w_rows);
      n_bias[i] = new Matrix(b_new, b_rows);
    }
    return new NeuralNetwork(structure, n_weights, n_bias);
  }
  
}
