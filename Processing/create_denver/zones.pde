/*------------------------------------------
 *
 * Zones: Wrapper for all Zone functionality
 *
 * A Zones obj has the power
 * to init and access Zone objects
 * 
 -------------------------------------------*/
 
class Zones{
  
  /*
   * Vars
   */
  int appHeight,
      zoneCols,
      zoneRows,
      zonesTotal,
      zoneWidth,
      zoneHeight,
      actives,
      score;
      
  Zone[] zoneArr;
  Target[] targetArr;
  
  /*
   * Constructor
   */
  Zones(int zc, int zr, Target[] t){
    this.zoneCols = zc;
    this.zoneRows = zr;
    this.targetArr = t;
    
    this.zonesTotal = this.zoneCols * this.zoneRows;
    this.zoneWidth = int(Constants.rawWidth / this.zoneCols);
    this.zoneHeight = int(Constants.rawHeight / this.zoneRows);
    this.zoneArr = this.getZones();
  }
  
  /*
   * getZones
   *
   * 
   *
   */
  Zone[] getZones(){
    Zone[] zones = new Zone[this.zonesTotal];
    
    int i=0;
    for(int y=0; y<this.zoneRows; y++){
      for(int x=0; x<this.zoneCols; x++){
        zones[i] = new Zone(i, this.zoneCols, x, y, this.zoneWidth, this.zoneHeight);
        i++;
      }
    }
    
    return zones;
  }
  
  /*
   * draw
   *
   * Iterate through each Zone
   * and Draw that dude.
   */
  void draw(int[] depthVals){
    this.actives = 0;
    this.score = 0;
    
    for(int i=0; i<this.zonesTotal; i++){
      this.zoneArr[i].draw(depthVals);
      
      boolean wasActive = this.zoneArr[i].getActiveState();
      if(wasActive) { 
        for(int t=0; t<targetArr.length; t++){ targetArr[t].updatePerhaps(i); }
        this.actives++; 
      }
      
      this.score += this.zoneArr[i].getState();
    }
  }
  
  void resetActives(){
    this.actives = 0;
    for(int i=0; i<this.zonesTotal; i++){
      this.zoneArr[i].resetActive();
    }
  }
  

  
  // Helper Methods
  
  /*
   * getTotalZones
   *
   * Return the total Zones
   */ 
  int getTotalZones(){
    return this.zonesTotal;  
  }
  
  /*
   * getZoneMap
   *
   * Return the array of Zone items
   */ 
  Zone[] getZoneMap(){
    return this.zoneArr;  
  }
  
  int getPercentActiveZones(){
    return round(map(this.actives, 0, this.zonesTotal, 0, 100));
  }
  
  int getScoredActiveZones(){
    int topscore = this.zonesTotal * 10;
    return round(map(this.score, 0, topscore, 0, 100));
  }
  
  int getIntActiveZones(){
    return this.actives;
  }
  
}
