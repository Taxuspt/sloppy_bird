class HumanEnvironment extends Environment {
  Bird bird;
  boolean flap;
  
  boolean saveTable = true;
  Table table;
  
  HumanEnvironment(){
    super();
    bird = new Bird();
    if(saveTable) setupTable();
  }
  
  void draw(){
    super.draw();

    if(!bird.active){
      active = false;
      if(saveTable) persistTable();
      return;
    }

    if(saveTable) updateTable();
    
    if(flap){
      flap = false;
      bird.flap(4);
    }
    
    bird.draw();
    
    long currScore = bird.getScore();
    bestScore =  currScore > bestScore ? currScore : bestScore;
    textSize(32);
    text(Math.round(currScore), 50, 40);
  }
  
  void flap() {
    flap = true;
  }
  
  void setupTable(){
    table = new Table();
    table.addColumn("hDistance");
    table.addColumn("vDistance");
    table.addColumn("vSpeed");
    table.addColumn("flap");
  }
  
  void updateTable(){
    TableRow newRow = table.addRow();
    newRow.setFloat("hDistance", (float)Math.abs((float)bird.getX() - (float)environment.pipeManager.getMinX()));
    newRow.setFloat("vDistance", (float)bird.getY() - (float)environment.pipeManager.getNextY());
    newRow.setFloat("vSpeed", bird.getvY());
    newRow.setInt("flap", flap?1:0);
    print(table.getRowCount()+"\n");
  }
  
  void persistTable(){
    // Save if at least 30 seconds
    if(table.getRowCount() > (speed * 30)){
      // Remove the last second of data (because the player dies)
      for(int i=0; i<speed; i++) table.removeRow(table.getRowCount()-1);
      String filename = str(year())+"-"+str(month())+"-"+str(day())+"_"+str(hour())+""+str(second());
      saveTable(table, "brains/"+filename+".csv");    
    }
  }
}
