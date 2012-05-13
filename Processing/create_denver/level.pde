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
      case 6:
        initLevel4();
        break;
      case 7:
        initTrans4();
        break;
      case 8:
        initLevel5();
        break;
      case 9:
        initTrans5();
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
    targets[0] = new Target(300, 132, 44, 60, this.cols, this.rows, 0); // lock
    targets[1] = new Target(300, 162, 44, 10, this.cols, this.rows, 1); // stub
    targets[2] = new Target(300, 172, 44, 10, this.cols, this.rows, 2); // stub
    
    targets[1].state = 2;
    targets[2].state = 2;
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
    targets[0] = new Target(278, 140, 147, 72, this.cols, this.rows, 0); // armoir thing
    targets[1] = new Target(153, 146, 80, 37, this.cols, this.rows, 1); // books
    targets[2] = new Target(503, 292, 37, 47, this.cols, this.rows, 2); // sofa (king wee todd did)
    
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
    
    //create targets
    this.targets = new Target[3];
    targets[0] = new Target(413, 169, 50, 65, this.cols, this.rows, 0); // right ice
    targets[1] = new Target(97, 90, 102, 80, this.cols, this.rows, 1); // lights
    targets[2] = new Target(197, 236, 95, 95, this.cols, this.rows, 2); // left ice
    
    createZones();
  }
  
  /*
   * initTrans3
   *
   * Initializes Transition 3
   */ 
  void initTrans3(){
    this.type = "transistion";
  }

  /*
   * initLevel4
   *
   * Initializes Level 4
   */ 
  void initLevel4(){
    this.type = "level";
    this.cols = 80;
    this.rows = 60;
    
    //create targets
    this.targets = new Target[3];
    targets[0] = new Target(151, 192, 64, 136, this.cols, this.rows, 0); // antelop
    targets[1] = new Target(37, 119, 99, 80, this.cols, this.rows, 1); // eagle
    targets[2] = new Target(502, 57, 75, 287, this.cols, this.rows, 2); // tree
    
    createZones();
  }
  
  /*
   * initTrans4
   *
   * Initializes Transition 4
   */
  void initTrans4(){
    this.type = "transistion";
  }
  
  /*
   * initLevel5
   *
   * Initializes Level 5
   */ 
  void initLevel5(){
    this.type = "level";
    this.cols = 80;
    this.rows = 60;
    
    //create targets
    this.targets = new Target[3];
    targets[0] = new Target(168, 415, 58, 25, this.cols, this.rows, 0); // ???
    targets[1] = new Target(234, 184, 30, 56, this.cols, this.rows, 1); // puppet
    targets[2] = new Target(428, 153, 45, 31, this.cols, this.rows, 2); // ???
    
    createZones();
  }
  
  /*
   * initTrans5
   *
   * Initializes Transition 5
   */
  void initTrans5(){
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
