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
      
      /*
       * 0 = inactive
       * 1 = active
       */
      state = 0;

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
    
    if(isActive(depthVals) == true){
      this.state = 1;
      rectHim();
    }
    else { this.state = 0; }
    
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
  
  void resetState(){
    this.state = 0;
  }
  
}
