import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

Integer[] getDefaultStruct(){
  return new Integer[]{3, 6, 4, 1};
}

BrainStruct loadBrainStruct(String path){
  print("Loading structure"+"\n");
  JSONObject jBrain = new JSONObject();
  BufferedReader reader = createReader(path);
  String line = null;
  try {
    line = reader.readLine();
    jBrain = new JSONObject(line);
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  print("Loaded file"+"\n");
  JSONArray jStructure = (JSONArray)jBrain.get("structure");
  Integer[] structure = new Integer[jStructure.length()];
  for(int i=0; i<jStructure.length(); i++){
    try {
      structure[i] = (int)(jStructure.get(i));
      print(structure[i]);
    } catch(Exception ex){
      print(ex);
    }
  }
  print("Loaded structure"+"\n");
  Matrix[] W = new Matrix[structure.length-1];
  Matrix[] B = new Matrix[structure.length-1];
  
  for(int i=0; i<structure.length-1; i++){
    JSONArray jW = (JSONArray)jBrain.get("W_"+i);
    double[] w = new double[jW.length()];
    for(int j=0; j<jW.length(); j++){
      try {
        w[j] = (double)(jW.get(j));
      } catch (Exception ex) {
        print(ex);
      }
    }
    print("Finished loading W_"+i+"\n");
    
    W[i] = new Matrix(w,structure[i+1]);
    W[i].print(1,3);
    
    JSONArray jb = (JSONArray)jBrain.get("b_"+i);
    double[] b = new double[jb.length()];
    for(int j=0; j<jb.length(); j++){
      try {
        b[j] = (double)(jb.get(j));
      } catch (Exception ex) {
        print(ex);
      }
    }
    print("Finished loading B_"+i+"\n");
    B[i] = new Matrix(b,structure[i+1]);
    B[i].print(1,3);
    
  }
  print("Returning");
  return new BrainStruct(structure, W, B);
}

class BrainStruct{
  Integer[] structure;
  Matrix[] W;
  Matrix[] b;
  
  BrainStruct(Integer[] structure_, Matrix[] W_, Matrix[] b_){
    structure = structure_;
    W = W_;
    b = b_;
  }
      
  void save(){
    String path = "brains/brain.json";
    JSONObject jBrain = new JSONObject();
    JSONArray jStructure = new JSONArray();
    for(int i=0; i<structure.length; i++){
      jStructure.put(structure[i]);
    }
    jBrain.put("structure", jStructure);
    
    for(int i=0; i<structure.length-1; i++){
      JSONArray wjTemp = new JSONArray();
      double[] wTemp = W[i].getColumnPackedCopy();
      for(int j=0; j<wTemp.length; j++){
        wjTemp.put(wTemp[j]);
      }
      jBrain.put("W_"+i, wjTemp);
      
      JSONArray bjTemp = new JSONArray();
      double[] bTemp = b[i].getColumnPackedCopy();
      for(int j=0; j<bTemp.length; j++){
        bjTemp.put(bTemp[j]);
      }   
      jBrain.put("b_"+i, bjTemp);
    }
    PrintWriter output = createWriter(path); 
    output.println(jBrain.toString());
    output.flush();
    output.close();
  }
}
