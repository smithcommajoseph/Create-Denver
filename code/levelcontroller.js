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


function bang(){
	var ob = getResolvedOb();
	outlet(0, ob.bg);
	outlet(1, ob.overlay);
}

function getResolvedOb(){
	var ob = {};
		
	if(level_type != "level"){
		ob.bg 		= "level"+LEVEL_TRANS_NAME+currentLevel+"."+MOV;
		ob.overlay 	= "clear."+PNG;
	} else {
		ob.bg		= "level"+LEVEL_BG_NAME+currentLevel+"."+JPG;
		ob.overlay	= "level"+LEVEL_OVERLAY_NAME+currentLevel+"."+PNG;
	}
	
	return ob;
}