// inlets and outlets
inlets = 1;
outlets = 4;

//Constants
	LEVEL_OVERLAY_NAME	= "_overlay_",
	LEVEL_BG_NAME		= "_bg_",
	LEVEL_TRANS_NAME	= "_trans_",
	PATH				= "/Users/joseph/Projects/create_denver/Max/media/";

function list(inputList){
	var levelArr = arrayfromargs(arguments),
		ob = getResolvedOb(levelArr[0], levelArr[1]);

	sendData(ob);
}

function bang(){
	var ob = getResolvedOb(0, "level");
	sendData(ob);
}

function getResolvedOb(currentLevel, level_type){
	var ob = {};
		
	if(level_type != "level"){
		ob.bg			= PATH+"level"+LEVEL_TRANS_NAME+currentLevel+".mov";
		ob.overlay_1	=
		ob.overlay_2	=
		ob.overlay_3	= PATH+"clear.png";
	} else {
		ob.bg			= PATH+"level"+LEVEL_BG_NAME+currentLevel+".jpg";
		ob.overlay_1	= PATH+"level"+LEVEL_OVERLAY_NAME+currentLevel+"_1.png";
		ob.overlay_2	= PATH+"level"+LEVEL_OVERLAY_NAME+currentLevel+"_2.png";
		ob.overlay_3	= PATH+"level"+LEVEL_OVERLAY_NAME+currentLevel+"_3.png";
	}
	
	return ob;
}

function sendData(ob){
	outlet(0, ob.bg);
	outlet(1, ob.overlay_1);
	outlet(2, ob.overlay_2);
	outlet(3, ob.overlay_3);
}