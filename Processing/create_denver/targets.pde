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
  completeScore = 90;
  
  String faderVal,
          faderValLast;
        
  boolean isComplete = false,
          isCompleteLast = false;
          
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

  void updatePerhaps(int zid) {
    
    for (int i=0; i<this.totalKeys; i++) {
      if (this.zoneIds[i] == zid && this.zoneStates[i] == false) {
        this.zoneStates[i] = true;
        score++;
      }
    }
    setFaderVal();
    if(getScoreAsPercent() >= this.completeScore) { this.isComplete = true; }
  }


  Target getTarget() {
    return this;
  }
  
  boolean getIsComplete() {
    return this.isComplete;
  }

  int getScoreAsPercent(){
    return round(map(this.score, 0, this.totalKeys, 0, 100));
  }
  
  float getScoreAsDecimal(){
    return getScoreAsPercent() / 100;  
  }
  
  void setFaderVal(){
    this.faderVal = ( getScoreAsPercent() == 0) ? "stop" : "bang";
  }
  
  void resetComplete() {
    this.isComplete = false;
  }
  
  void resetScore() {
    this.score = 0;
  }
  
}

