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

int sumPt = sum(j in Jobs, i in Acts) Ops[j][i].pt;

dvar interval acts[j in Jobs][i in Acts] 
	in 0..sumPt 
	size Ops[j][i].pt;
	
dvar sequence machines[m in Mchs] 
	in all(j in Jobs, i in Acts : Ops[j][i].mch == m) acts[j][i];
	
dexpr int makespan =
	max(j in Jobs) endOf(acts[j][nbMchs-1]);
	
execute {
	cp.param.Workers = 1;
	cp.param.FailLimit = 10000;
}

minimize 
  makespan;
subject to {
  
  // A machine can only process one activity at a time.
  forall(m in Mchs)
    noOverlap(machines[m]);
  
  // Each job is a chain of activities.
  forall(j in Jobs, i in 0..nbMchs-2)
    endBeforeStart(acts[j][i], acts[j][i+1]);
}