using CP;

int nbCarTypes = ...; // number of car types
int nbOptions  = ...; // number of options
int nbSlots    = ...; // number of slots

range   CarTypes = 1..nbCarTypes; 
range   Options  = 1..nbOptions;
range   Slots    = 1..nbSlots;

int demand[CarTypes]          = ...;	
// demand per car type
int option[CarTypes][Options] = ...;	
// option[c][o] == 1 means car type c has option o
int maxSequence[Options]      = ...;	
// maxSequence[o] gives maximal number of 
// consecutive slots that option o can be installed. 
int minSequence[Options]      = ...; 
// minSequence[o] gives minimal number of 
// consecutive slots for option o. 

assert forall(c in CarTypes, o in Options) Option0or1: 
	(option[c][o] == 0 || option[c][o] == 1);
assert SumOfDemandsEqualsSlots: sum(c in CarTypes) demand[c] == nbSlots;													

dvar int cartype[Slots] in CarTypes;

subject to {
	// number of slots containing car type c equals 
	// the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);
   		   
	// For each option o one cannot have more than 
	// maxSequence[o] cars having option o.
	forall(o in Options, s in 1..nbSlots-maxSequence[o])
		(sum(s1 in s..s+maxSequence[o]) option[cartype[s1]][o]) <= maxSequence[o]; 

	// The options of the first car must appear at least 
	// minSequence times consecutively.
	forall(o in Options)
		(option[cartype[1]][o] == 1) 
		=> 
		(sum(s in 1..minSequence[o]) option[cartype[s]][o]) == minSequence[o];

	// Every option o that car in slot s does not have but car
	// in slot s+1 does have, must appear minSequence[o] times 
	// consecutively from slot[s+1] to slot[s+minSequence[o]].  	
	forall (o in Options, s in 1..nbSlots-minSequence[o])
			((option[cartype[s]][o] == 0) && (option[cartype[s+1]][o] == 1))
			=>
			(sum(s1 in s+1..s+minSequence[o]) option[cartype[s1]][o]) == minSequence[o];
			
	// The options of the last car must appear at least 
	// minSequence times consecutively.
	forall(o in Options)
		(option[cartype[nbSlots]][o] == 1) 
		=> 
		(sum(s in nbSlots-minSequence[o]+1..nbSlots) option[cartype[s]][o]) == minSequence[o];	
};

