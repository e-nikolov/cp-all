using CP;

int nbJobs = ...;
int nbMchs = ...;

range Jobs = 0..nbJobs-1;
range Mchs = 0..nbMchs-1;
range Acts = 0..nbMchs-1; 

tuple Operation {
  int mch; // Machine
  int pt;  // Processing time
};

Operation Ops[j in Jobs][i in Acts] = ...;

assert forall(j in Jobs) 
	AllMachinesUsedInJob:(card({m | m in Mchs, i in Acts : Ops[j][i].mch == m}) == nbMchs);



dvar interval acts[j in Jobs][i in Acts] 
	in  
	size Ops[j][i].pt
	
dvar sequence machines[m in Mchs] 
	in 
	
	
	
execute {
	cp.param.Workers = 1;
}

minimize 
  makespan;
subject to {

  forall(j in Jobs, i in 0..nbMchs-2)
    endBeforeStart(acts[j][i], acts[j][i+1]);
}