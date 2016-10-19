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

assert forall(j in Jobs, i in Acts) 
	MachineNumberTooLarge: Ops[j][i].mch < nbMchs;
assert forall(j in Jobs, i in Acts) 
	NegativeMachineNumber: Ops[j][i].mch >= 0;
assert forall(j in Jobs) 
	AllMachinesUsedInJob:(card({m | m in Mchs, i in Acts : Ops[j][i].mch == m}) == nbMchs);
assert forall(j in Jobs, i in Acts) 
	ProcessingTimeShouldBePositive: Ops[j][i].pt > 0;
	
int sumPt = sum(j in Jobs, i in Acts) Ops[j][i].pt;

int UBMakespan = ((sumPt div 5)+1)*7;
stepFunction we = 
	stepwise(i in 0..(UBMakespan div 7)+1, wdays in 0..1) {100*wdays->(i*7)+(5*wdays);0};

dvar interval acts[j in Jobs][i in Acts] 
	in 0..UBMakespan 
	size Ops[j][i].pt 
	intensity we;
	
dvar sequence machines[m in Mchs] 
	in all(j in Jobs, i in Acts : Ops[j][i].mch == m) acts[j][i];

dexpr int makespan =
	max(j in Jobs) endOf(acts[j][nbMchs-1]);

execute {
	cp.param.Workers = 1;
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

