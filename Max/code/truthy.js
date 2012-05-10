inlets = 1;
outlets = 3;

var t0_isComplete,
	t1_isComplete,
	t2_isComplete;

function bang(){
	if(t0_isComplete == true){
		post("target0");
		post("bang");
		post("\n");
		//1., 0 1000
		outlet(0, "bang");
	}
	if(t1_isComplete == true){
		post("target1");
		post("bang");
		post("\n");
		//1., 0 1000
		outlet(1, "bang");
	}
	if(t2_isComplete == true){
		post("target2");
		post("bang");
		post("\n");
		//1., 0 1000
		outlet(2, "bang");
	}
}