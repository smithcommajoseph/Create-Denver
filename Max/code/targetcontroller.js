inlets = 1;
outlets = 12;


var completeScore = 90,

	t1_score,
	t1_bos,
	t1_bosLast,

	t2_score,
	t2_bos,
	t2_bosLast,

	t3_score,
	t3_bos,
	t3_bosLast;

function bang(){
	post(typeof list);
	post(list);
	post("\n");
}

function list(inputList){
	var targetArr = arrayfromargs(arguments),
		len = targetArr.length,
		ob = {};

	t1_score = targetArr[1];
	t1_bos = (t1_score !== 0) ? "bang" : "stop";

	ob = {
		//			isComplete,		score		bangOrStop?		lowerLimit		upperLimit
		target_1:	[targetArr[0],	t1_score,	t1_bos,			1 - t1_score,	Math.min(1, 1.25 - t1_score) ],
		target_2:	[targetArr[2],	targetArr[3],	(targetArr[3] !==0) ? "bang" : "stop" ],
		target_3:	[targetArr[4],	targetArr[5],	(targetArr[5] !==0) ? "bang" : "stop" ]
	};




	// getFadeVals();

	sendData(ob);
}

function sendData(ob){
	if(t1_bos != t1_bosLast){
		post("called");
		outlet(0, ob.target_1[2]);		// bangOrStop?
		outlet(1, ob.target_1[0]);		// isComplete?
		t1_bosLast = t1_bos;
	}

		outlet(2, ob.target_1[4]);		// Start fade val
		outlet(3, ob.target_1[3]);		// End fade val


	// outlet(4, ob.target_2[2]);		// bangOrStop?
	// outlet(5, ob.target_2[0]);		// isComplete?
	// outlet(6, ob.target_2[0]);		// Start fade val
	// outlet(7, ob.target_2[0]);		// End fade val

	// outlet(8, ob.target_3[2]);		// bangOrStop?
	// outlet(9, ob.target_3[0]);		// isComplete?
	// outlet(10, ob.target_3[0]);		// Start fade val
	// outlet(11, ob.target_3[0]);		// End fade val
}