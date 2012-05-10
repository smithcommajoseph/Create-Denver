class Level{
  
  /*
   * Vars
   */
  String type;
  
  int bid,
      cols,
      rows;
  
  boolean transitionDone = false;
  
  Target[] targets;
  Zones zones;
  
  /*
   * Constructor
   */
  Level(int b){
    this.bid = b;
    
    switch(this.bid){
      case 0: 
        initLevel1();
        break;
      case 1:
        initTrans1();
        break;
      case 2:
        initLevel2();
        break;
      case 3:
        initTrans2();
        break;         
      case 4:
        initLevel3();
        break;
      case 5:
        initTrans3();
        break;
    }
  }
  
  /**********************/
  /* Level Initializers */  
  /**********************/
  
  /*
   * initLevel1
   *
   * Initializes Level 1
   */
  void initLevel1(){
    this.type = "level";
    this.cols = 80;
    this.rows = 60;
    
    //create targets
    this.targets = new Target[3];
    targets[0] = new Target(248, 52, 171, 231, this.cols, this.rows, 0); // armoir thing
    targets[1] = new Target(483, 111, 81, 31, this.cols, this.rows, 1); // books
    targets[2] = new Target(125, 417, 66, 39, this.cols, this.rows, 2); // stub circle
    
    createZones();
  }
  
  /*
   * initTrans1
   *
   * Initializes Transition 1
   */
  void initTrans1(){
    this.type = "transistion";
  }
  
  /*
   * initLevel2
   *
   * Initializes Level 2
   */
  void initLevel2(){
    this.type = "level";
    this.cols = 80;
    this.rows = 60;
    
    //create targets
    this.targets = new Target[3];
    targets[0] = new Target(226, 288, 88, 66, this.cols, this.rows, 0); // lower circle
    targets[1] = new Target(47, 87, 92, 67, this.cols, this.rows, 1); // top left circle
    targets[2] = new Target(484, 138, 100, 87, this.cols, this.rows, 2); // right cicle
    
    createZones();
  }
  
  /*
   * initTrans2
   *
   * Initializes Transition 2
   */ 
  void initTrans2(){
    this.type = "transistion";
  }

  /*
   * initLevel3
   *
   * Initializes Level 3
   */ 
  void initLevel3(){
    this.type = "level";
    this.cols = 80;
    this.rows = 60;
  }
  
  /*
   * initTrans3
   *
   * Initializes Transition 3
   */
  void initTrans3(){
    this.type = "transistion";
  }
  
  void createZones() {
    this.zones = new Zones(this.cols, this.rows, this.targets);
  }
  
  boolean hasZones(){
    return (this.type == "level") ? true : false; 
  }
  
  boolean isComplete(){
    if(this.hasZones()){
      
      int len = this.targets.length,
      cnt = 0;
      for(int i=0; i<len; i++){
        if(this.targets[i].getState() == 2){
          cnt++;
        }
      }
      return (cnt == len) ? true : false;
      
    }
    
    else {
      
      return (this.transitionDone) ? true : false;
    }
  }
  
}
