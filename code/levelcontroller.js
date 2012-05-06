// inlets and outlets
inlets = 1;
outlets = 2;

//Vars
var currentLevel = 0,
	lastLevel = 0,
	level_type = "level";

//Constants	
	LEVEL_OVERLAY_NAME 	= "_overlay_",
	LEVEL_BG_NAME		= "_bg_",
	LEVEL_TRANS_NAME	= "_trans_",
	JPG					= "jpg",
	PNG					= "png",
	MOV					= "mov";
	PATH				= "/Users/joseph/Documents/Max 6 Projects/create_denver/media/";


function bang(){
	var ob = getResolvedOb();
	outlet(0, ob.bg);
	outlet(1, ob.overlay);
}

function getResolvedOb(){
	var ob = {};
		
	if(level_type != "level"){
		ob.bg 		= PATH+"level"+LEVEL_TRANS_NAME+currentLevel+"."+MOV;
		ob.overlay 	= PATH+"clear."+PNG;
	} else {
		ob.bg		= PATH+"level"+LEVEL_BG_NAME+currentLevel+"."+JPG;
		ob.overlay	= PATH+"level"+LEVEL_OVERLAY_NAME+currentLevel+"."+PNG;
	}
	
	return ob;
}