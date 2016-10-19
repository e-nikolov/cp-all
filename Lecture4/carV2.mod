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

assert forall(c in CarTypes, o in Options) Option0or1: 
	(option[c][o] == 0 || option[c][o] == 1);
assert SumOfDemandsEqualsSlots: 
	sum(c in CarTypes) demand[c] == nbSlots;

dvar int cartype[Slots] in CarTypes;

execute {
	cp.param.Workers = 1;
}

subject to {
	// number of slots containing car type c equals 
	// the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);
   		   
	// no two consecutive slots can contain two cars that 
	// have the same option
	forall(o in Options, s in 1..nbSlots-1)
		//(option[cartype[s]][o] == 1) => (option[cartype[s+1]][o] == 0);
		option[cartype[s]][o]+option[cartype[s+1]][o] <= 1;
};