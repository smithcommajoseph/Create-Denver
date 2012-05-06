/*------------------------------------------
 *
 * Zone: A singular zone
 *
 * A Zone is init'd and accessed
 * through the Zones object
 * 
 ------------------------------------------*/
 
class Zone{
  
  /*
   * Vars
   */
  int pointer,
      modX,
      modY,
      zoneCols,
      imageIndex,
      totalKeys,
      zoneWidth,
      zoneHeight,
      drawWidth,
      drawHeight,
      startX,
      startY,
      endX,
      endY,
      
      maxStates = 10,
      state = 0,
      opacityMod = 100/maxStates;
  
  float halfState = 0;
  
  boolean wasActive = false;
  
  /*
   * Constructor
   */ 
  Zone(int i, int zc, int mx, int my, int zw, int zh){
    this.pointer = i;
    this.zoneCols = zc;
    this.modX = mx;
    this.modY = my;
    this.zoneWidth = zw;
    this.zoneHeight = zh;
    
    this.startX = (this.modX * this.zoneWidth) * Constants.sizeMod;
    this.startY = (this.modY * this.zoneHeight) * Constants.sizeMod;
    this.drawWidth = this.zoneWidth * Constants.sizeMod;
    this.drawHeight = this.zoneHeight * Constants.sizeMod;

    this.totalKeys = this.zoneWidth * this.zoneHeight;    
    this.imageIndex = (Constants.rawWidth * this.zoneHeight * this.modY) + (this.zoneWidth * this.modX);
  }

  /*
   * isActive
   *
   * Loops through the passed in depthVals
   * and will return true if any of the scanned 
   * pixels are in the given range.
   */
  boolean isActive(int[] depthVals){
    int idx = this.imageIndex,
        currentDepthVal;
        
    for(int c=1; c<this.totalKeys; c+=1){
      currentDepthVal = depthVals[idx];
      
      if(currentDepthVal > Constants.minZ && currentDepthVal < Constants.maxZ){
        // return instantly if we're true  
        return true;
      }
      
      idx = (c%this.zoneWidth == 0) ? idx+Constants.rawWidth - this.zoneWidth + 1 : idx+1;
    }
    
    // otherwise, return false
    return false;
  }
  
  /*
   * draw
   *
   * will draw depending on a Zone's active state
   */
  void draw(int[] depthVals){
    
    if(this.wasActive == true){
      rectHim();
    } else {
      boolean isActive = isActive(depthVals);
      if(isActive == true){
        this.wasActive = true;
        this.state = this.maxStates;
        rectHim();
      } else {
        if(this.state != 0){
          this.state = ceil(this.halfState);  
        }
      }
    }
    
  }
  
  void rectHim(){
    rect(this.startX, this.startY, this.drawWidth, this.drawHeight);
    fill(200,200,200);
    noStroke();
  }
  
  // Helper Methods

  /*
   * getPointer
   *
   * Returns the index of this Zone
   */
  int getPointer(){
    return this.pointer;
  }
  
  int getState(){
    return this.state;
  }
  
  boolean getActiveState(){
    return this.wasActive;  
  }
  
  /*
   * getZone
   *
   * will return the Zone in it's fullness
   */
  Zone getZone(){
    return this;
  }
  
  /*
   * resetActive
   *
   * reset Zone's active state
   */
  void resetActive(){
    this.wasActive = false;  
  }
  
}
