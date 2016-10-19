using CP;

int nbCarTypes = ...; // number of car types
int nbOptions  = ...; // number of options
int nbSlots    = ...; // number of slots

range CarTypes = 1..nbCarTypes; 
range Options  = 1..nbOptions;
range Slots    = 1..nbSlots;

int demand[CarTypes]          = ...;	
// demand per car type
int option[CarTypes][Options] = ...;	
// option[c][o] == 1 means car type c has option o
int maxSequence[Options]      = ...;	
// maxSequence[o] gives maximal number of 
// consecutive slots that option o can be installed.
																	
assert forall(c in CarTypes, o in Options) Option0or1: 
	(option[c][o] == 0 || option[c][o] == 1);
assert SumOfDemandsEqualsSlots: 
	sum(c in CarTypes) demand[c] == nbSlots;													
																			
dvar int cartype[Slots] in CarTypes;

execute {
	cp.param.Workers = 1;
//	cp.param.DefaultInferenceLevel = "Extended";
}

subject to {
	// number of slots containing car type c equals 
	// the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);
   		   
	// For each option o one cannot have more than 
	// maxSequence[o] cars having option o.
///*
	// Version 1.
   	forall(o in Options, s in 1..nbSlots-maxSequence[o])
     	((sum(s1 in s..s+maxSequence[o]-1) option[cartype[s1]][o]) == maxSequence[o])
     	=>
		option[cartype[s+maxSequence[o]]][o] == 0;  	
//*/	
/*		
	// Version 2.
	forall(o in Options, s in 1..nbSlots-maxSequence[o])
		(sum(s1 in s..s+maxSequence[o]) option[cartype[s1]][o]) <= maxSequence[o]; 
*/
};