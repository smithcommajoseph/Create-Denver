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
  state = 0;

  boolean wasActive = false;
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
    
    if(getScore() >= 90) { this.wasActive = true; }
  }

  int getState() {
    return this.state;
  }

  boolean getActiveState() {
    return this.wasActive;
  }

  Target getTarget() {
    return this;
  }

  void resetActive() {
    this.wasActive = false;
  }

  int getScore(){
    return round(map(this.score, 0, this.totalKeys, 0, 100));
  }
  
  void resetScore() {
    this.score = 0;
  }
  
  String getMessageName(){
    return "/target_"+this.pointer;
  }
  
  boolean getMessageVal(){
    return this.wasActive; 
  }
}

