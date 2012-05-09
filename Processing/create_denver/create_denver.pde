import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;

/*
 * Constants
 */
interface Constants {
  public static final int rawWidth = 640;
  public static final int rawHeight = 480;
  public static final int sizeMod = 1;
  public static final int minZ = 610;
  public static final int maxZ = 1525;
  public static final int stages = 4 - 1;
  public static final String oscNamespace = "/createdenver";
}

/*
 * Vars
 */
boolean stageOneIsActive =  true, 
stageOneTransIsActive = false, 
stageTwoIsActive = false;

int appWidth = Constants.rawWidth * Constants.sizeMod, 
appHeight = Constants.rawHeight * Constants.sizeMod, 
totalImagePx, 
scoredActiveZones, 
currentLevel = 0,
lastLevel = 0;

SimpleOpenNI kinect;
OscP5 oscP5;
NetAddress remote;
Zones zones;
Level level;

/*
 * Setup
 */
void setup() {
  //app config
  size(appWidth, appHeight, P3D);
  frameRate(20);
  background(0);

  totalImagePx = Constants.rawWidth * Constants.rawHeight;

  // Init Kinect via SimpleOpenNI
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  // Init OSC biz
  oscP5 = new OscP5(this, 60001);
  remote = new NetAddress("127.0.0.1", 60000);

  // Create our Levels
  level = initLevel();
}

/*
 * draw
 */
void draw() {
  // handle scoring
  if (level.isComplete() == true) {
    println("levelcomplete");
    //      level.zones.resetActives();

    if (currentLevel < Constants.stages) {
      currentLevel++;
    } 
    else {
      currentLevel = 0;
    }
    println("currentLevel: "+currentLevel);
    level = initLevel();
    
//    sendOSC();
  }

  background(0);
  
  if ( level.hasZones() ) {
    kinect.update();
    int[] depthValues = kinect.depthMap();
    // draw and score (score must happen after draw)
    level.zones.draw(reverseXVals(depthValues));
    scoredActiveZones = level.zones.getScoredActiveZones();
  }

  sendOSC();
}

void mousePressed(){
  level.transitionDone = true;
}

Level initLevel() {
  return new Level(currentLevel);
}

int[] reverseXVals(int[] depthValues) {
  int[] returnArr = new int[totalImagePx];

  // reverse our pixels on the x axis
  for (int y=0; y<Constants.rawHeight; y++) {
    for (int x=0; x<Constants.rawWidth; x++) {
      int reversedX = Constants.rawWidth - x - 1, 
      i = x + y * Constants.rawWidth, 
      ri = reversedX + y * Constants.rawWidth;
      returnArr[i] = depthValues[ri];
    }
  }

  return returnArr;
}

void sendOSC() {
  //send target data
  if(level.hasZones()){
    
    for (int i=0; i<level.targets.length; i++) {
      boolean isComplete = level.targets[i].isComplete,
              isCompleteLast = level.targets[i].isCompleteLast;
      
//      println("/targets/target_"+i+"/isComplete");
//      println(isComplete != isCompleteLast);
        //isComplete data
//        OscMessage isCompleteData = new OscMessage( Constants.oscNamespace+"/targets/target_"+i+"/isComplete" );
//        isCompleteData.add( level.targets[i].isComplete );
//        oscP5.send(isCompleteData, remote);
        
      if(isComplete != isCompleteLast){
        
        //isComplete data
        OscMessage isCompleteData = new OscMessage( Constants.oscNamespace+"/targets/target_"+i+"/isComplete" );
        isCompleteData.add( "bang" );
        oscP5.send(isCompleteData, remote);
        println("target"+i+" isComplete");
        
        OscMessage isActiveData = new OscMessage( Constants.oscNamespace+"/targets/target_"+i+"/inactive" );
        isActiveData.add( "bang" );
        oscP5.send(isActiveData, remote);
        println("target"+i+" inactive");
        
        level.targets[i].isCompleteLast = level.targets[i].isComplete;
      } else {
       
        //isActive data
        boolean isActive = level.targets[i].isActive,
                isActiveLast = level.targets[i].isActiveLast;
        
        if(isActive != isActiveLast){
          OscMessage isActiveData = new OscMessage( Constants.oscNamespace+"/targets/target_"+i+"/active" );
          isActiveData.add( "bang" );
          oscP5.send(isActiveData, remote);
          println("target"+i+" active");
          
          level.targets[i].isActiveLast = level.targets[i].isActive;
        } 
      
      }       
      
    }
   
  }
  
  //send level data
  if(lastLevel != currentLevel){   
    OscMessage levelData = new OscMessage( Constants.oscNamespace+"/level" );
    levelData.add( currentLevel );
    levelData.add( level.type );
    oscP5.send(levelData, remote);
    
    lastLevel = currentLevel;
  }
}

void oscEvent(OscMessage theOscMessage) {
  String addr = theOscMessage.addrPattern(); // Creates a string out of the OSC message
   if (addr.indexOf("/frommax/trannycall") != -1) {
    println(theOscMessage.get(0).intValue());
    level.transitionDone = true;
  }
}

public void stop() {
  dispose();
}

void dispose() {
  //  if(kinect!=null){
  //    println("stopping kinect");
  //    SimpleOpenNI.Shutdown();  
  //  }
}

