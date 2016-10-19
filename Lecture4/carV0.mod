using CP;

int nbCarTypes = ...; // number of car types
int nbSlots    = ...; // number of slots

range CarTypes = 1..nbCarTypes; 
range Slots    = 1..nbSlots;

int demand[CarTypes] = ...; // demand per car type

//assert SumOfDemandsEqualsSlots: 
//	sum(c in CarTypes) demand[c] == nbSlots;

dvar int cartype[Slots] in CarTypes;

subject to {
	// number of slots containing car type c equals the demand for that car type
	forall(c in CarTypes)
		demand[c] == count(cartype, c);
   		   		
	// no two consecutive slots can contain two cars of the same type
	forall(s in 1..nbSlots-1)
		cartype[s] != cartype[s+1];
}