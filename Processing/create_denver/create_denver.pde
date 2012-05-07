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
  public static final int stages = 3 - 1;
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
    
    sendOSC();
  }

  background(0);
  
  if ( level.hasZones() ) {
    kinect.update();
    int[] depthValues = kinect.depthMap();
    // draw and score (score must happen after draw)
    level.zones.draw(depthValues);
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
    OscMessage targetsData = new OscMessage( Constants.oscNamespace+"/targets" );
    for (int i=0; i<level.targets.length; i++) {
      targetsData.add( level.targets[i].getIsComplete() );
      targetsData.add( level.targets[i].getScoreAsDecimal() );
    }
    oscP5.send(targetsData,remote);
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

public void stop() {
  dispose();
}

void dispose() {
  //  if(kinect!=null){
  //    println("stopping kinect");
  //    SimpleOpenNI.Shutdown();  
  //  }
}

