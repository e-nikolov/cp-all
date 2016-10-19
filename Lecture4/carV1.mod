using CP;

int blocksize      = ...; 
// the size of the blocks where no car type
// can appear more than once
int nbCarTypes     = ...; // number of car types
int nbSlots        = ...; // number of slots

range CarTypes     = 1..nbCarTypes; 
range Slots        = 1..nbSlots;

int demand[CarTypes] = ...; // demand per car type

assert SumOfDemandsEqualsSlots: 
	sum(c in CarTypes) demand[c] == nbSlots;

dvar int cartype[Slots] in CarTypes;

subject to {
	// number of slots containing car type c equals 
	// the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);
   		   
	// no "blocksize" consecutive slots can contain more
	// than one car of the same type
	forall(s in 1..nbSlots-blocksize+1)
		allDifferent
			(all(s1 in Slots : s <= s1 <= s+blocksize-1) cartype[s1]);  
}	