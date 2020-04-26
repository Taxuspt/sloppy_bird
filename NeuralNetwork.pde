import Jama.*;

class NeuralNetwork {
  
  Integer[] structure;
  Matrix[] weights;
  Matrix[] bias;
  Matrix[] currentActivation;
  
  NeuralNetwork(Integer[] structure_, Matrix[] W, Matrix[] b){
    structure = structure_;
    currentActivation = _initCA();
    weights = W;
    bias = b;
  }
  
  NeuralNetwork(Integer[] structure_) {
    
    structure = structure_;
    currentActivation = _initCA();
    weights = new Matrix[structure.length-1];
    bias = new Matrix[structure.length-1];
    
    for(int i = 1; i<structure.length; i++){
      Double he = Math.sqrt(2/structure[i-1]); // He initialization
      weights[i-1] = Matrix.random(structure[i], structure[i-1]).minus(new Matrix(structure[i], structure[i-1], 0.5)).times(1);
      bias[i-1] = new Matrix(structure[i], 1, 0);
    }   
  }
  
  Matrix[] _initCA(){
    Matrix[] ca = new Matrix[structure.length];
    for(int i=0; i<structure.length; i++){
      ca[i] = new Matrix(structure[i], 1);
    }
    return ca;
  }
  
  double[] activate(double[] input_) {
    if(input_.length == structure[0]){
      Matrix input = new Matrix(input_, structure[0]);
      assert currentActivation[0].getRowDimension() == input.getRowDimension();
      assert currentActivation[0].getColumnDimension() == input.getColumnDimension();
      currentActivation[0] = input;
      for(int i=0; i<weights.length; i++){
        Matrix a1 = weights[i].times(input);
        if(i < weights.length-1){
          input = relu((a1).plus(bias[i]));  
        } else {
          input = sigmoid((a1).plus(bias[i])); // Last layer uses a sigmoid instead of ReLU
        }
        assert currentActivation[i+1].getRowDimension() == input.getRowDimension();
        assert currentActivation[i+1].getColumnDimension() == input.getColumnDimension();
        currentActivation[i+1] = input;
      }
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
  
  Matrix relu(Matrix input){
    int r = input.getRowDimension();
    int c = input.getColumnDimension();
    Matrix n = new Matrix(r, c);
    for(int i=0; i<r; i++){
      for(int j=0; j<c; j++){
        float v = relu((float)input.get(i, j));
        n.set(i, j, v);
      }
    }
    return n;
  }
  
  float relu(float x){
    return x > 0? x : 0;
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

class NeuralActivation {
  
  Integer[] _structure;
  Integer _columns;
  Integer _maxRows;
  NeuralNetwork _nn;
  
  NeuralActivation(NeuralNetwork nn){
    _nn = nn;
    _structure = nn.structure;
    _columns = _structure.length;
    _maxRows = getMax(_structure);    
  }
  
  void draw(int x,  int y){
    // TODO: Find a good way to normalize the neuron' colors.
    // Input and output should be normalized differently. 
    // ReLU vs Sigmoid should also be different
    
    int h = 20;
    int w = 60;
    int radius = 15;
    
    pushMatrix();
    translate(x, y);
    fill(225, 227, 227, 200);
    rect(-20, 0, (_columns-1) * w + radius + 20, _maxRows * h);
    Matrix[] ca = _nn.currentActivation;
    for (int i=0; i<_structure.length; i++){
      double[] cl = ca[i].getColumnPackedCopy();
      double cl_max = getMax(cl);
      double cl_min = getMin(cl);
      for(int j=0; j<_structure[i]; j++){
        float vY = (_maxRows * h) / (_structure[i] + 1);
        fill(Math.round(255*(cl[j]-cl_min)/(cl_max-cl_min)));
        circle(i*w, vY*j + vY, radius);
      }
    }
    popMatrix();
  
  }
  
}
