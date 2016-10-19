using CP;

int nbCarTypes = ...; // number of car types
int nbOptions  = ...;
int nbSlots    = ...; // number of slots

range CarTypes = 1..nbCarTypes;
range Options  = 1..nbOptions; 
range Slots    = 1..nbSlots;

int demand[CarTypes] = ...; // demand per car type

int option[CarTypes][Options] = ...;

dvar int cartype[Slots] in CarTypes;


assert forall(c in CarTypes, o in Options) Option0or1: 
	(option[c][o] == 0 || option[c][o] == 1);
assert SumOfDemandsEqualsSlots: 
	sum(c in CarTypes) demand[c] == nbSlots;

execute {
	cp.param.Workers = 1;
}

int numberOfCarsWithOption[o in Options]; 
dvar int slotHasOption[Slots][Options] in 0..1; 


subject to {
	forall(ct in CarTypes) count(cartype, ct) == demand[ct];

	forall(s in 2..nbSlots, o in Options)
	  option[cartype[s]][o] + option[cartype[s-1]][o] < 2;
	
}