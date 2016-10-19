using CP;

int nbCarTypes = ...; // number of car types
int nbOptions  = ...; // number of options
int nbSlots    = ...; // number of slots

range CarTypes = 1..nbCarTypes; 
range Options  = 1..nbOptions;
range Slots    = 1..nbSlots;

// demand per car type
int demand[CarTypes]          = ...;	
// option[c][o] == 1 means car type c has option o
int option[CarTypes][Options] = ...;	

int numberOfCarsWithOption[o in Options] = 
	sum(c in CarTypes) demand[c] * option[c][o];

assert forall(c in CarTypes, o in Options) Option0or1: 
	(option[c][o] == 0 || option[c][o] == 1);
assert SumOfDemandsEqualsSlots: sum(c in CarTypes) demand[c] == nbSlots;

dvar int cartype[Slots] in CarTypes;
dvar int slotHasOption[Slots][Options] in 0..1;

execute {
  //First decide on cartype variables as these are the real decision variables.
  //cp.setSearchPhases(cp.factory.searchPhase(cartype));
  
  cp.param.Workers = 1;

  for (var o in Options) {
    writeln("Option " + o + " occupancy is "
          + numberOfCarsWithOption[o] + " / " + nbSlots);
  }
}

subject to {
	// number of slots containing car type c equals the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);

	// connecting cartype and slotHasOption variables
	forall (s in Slots, o in Options)
		slotHasOption[s][o] == (option[cartype[s]][o]);
   		   
	// no two consecutive slots can contain two cars that have the same option
	forall(o in Options, s in 1..nbSlots-1)
	  slotHasOption[s][o]+slotHasOption[s+1][o] <= 1;

	// Redundant constraints
	forall(o in Options) {
		forall (s in 1..nbSlots-1) {
			// Number of times option o appeared until slot s + the maximal
			// number of times o can appear after s, needs to be at least
			// the total number of cars with o.
			// The maximal number of times o can be used after slot s is
			// (nbSlots - s + 1) div 2
			(sum(t in 1..s) slotHasOption[t][o]) + ((nbSlots - s + 1) div 2) 
				>= numberOfCarsWithOption[o];
			// Similar reasoning for known appearances of o after slot s.
			(sum(t in (s+1)..nbSlots) slotHasOption[t][o]) + ((s + 1) div 2) 
				>= numberOfCarsWithOption[o];
		}
	}
};
