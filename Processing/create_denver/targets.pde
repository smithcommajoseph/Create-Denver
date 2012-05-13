class Target {

  int x, 
  y, 
  targetWidth, 
  targetHeight, 
  zoneCols, 
  zoneRows,
  totalKeys, 
  pointer,
    
  score = 0,
  completeScore = 90,
  
  /*
   * 0 = inactive
   * 1 = active
   * 2 = complete
   */
  state = 0,
  stateLast = 0;
          
  boolean[] zoneStates;
  int[] zoneIds;

  Target(int x, int y, int w, int h, int c, int r, int p) {
    this.x = x;
    this.y = y;
    this.targetWidth = w;
    this.targetHeight = h;
    this.zoneCols = c;
    this.zoneRows = r;
    this.pointer = p;
    
    getZoneIds();
  } 

  void getZoneIds() {
    int zoneWidth = int(Constants.rawWidth / this.zoneCols);
    int zoneHeight = int(Constants.rawHeight / this.zoneRows);
    int across = ceil(this.targetWidth/zoneWidth);
    int down = ceil(this.targetHeight/zoneHeight);
    int idx = this.zoneCols * floor(y/zoneHeight) + floor(x/zoneWidth);
    int zid;
    int i = 0;
    
    this.totalKeys = across*down;
    this.zoneIds = new int[this.totalKeys];
    this.zoneStates = new boolean[this.totalKeys];
    
    for (int y=0; y<down; y++) {
      for (int x=0; x<across; x++) {
        zid = idx + y*this.zoneCols + x;
        this.zoneIds[i] = zid;
        this.zoneStates[1] = false;
        i++;
      }
    }
  }

  void update(Zone[] zoneArr){
    if(getState() != 2){
      int activeCount = 0;
      for(int i=0; i<this.zoneIds.length; i++){
        if(zoneArr[this.zoneIds[i]].getState() == 1 ){
          activeCount++;
        }
      }
      
      if(activeCount == 0){ 
        this.score = 0;
      }
      else {
        this.score += activeCount;
      }  
    } 
  }

  int getState(){
    int returnState;
    
    if(this.score == 0)                                  { returnState = 0; }
    else if ( getScoreAsPercent() > this.completeScore)  { returnState = 2; }
    else                                                 { returnState = 1; }
    
    this.state = returnState;
    return returnState;
  }

  int getScoreAsPercent(){
    //throttled score
    int localScore = floor(this.score * 0.1);
    return round(map(localScore, 0, this.totalKeys, 0, 100));
  }
  
  float getScoreAsDecimal(){
    return getScoreAsPercent() / 100;  
  }
  
  void resetScore() {
    this.score = 0;
  }
  
}

