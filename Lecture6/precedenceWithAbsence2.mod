using CP;

int n = 3;

dvar interval acts[1..n]
	optional
	size 10;

// For version 3
dvar interval precActs[1..n];

minimize
  max(i in 1..n) endOf(acts[i]);
subject to {

	sum(i in 1..n) presenceOf(acts[i]) >= 2;

	// First basic version. Problem is that if acts[2] becomes absent, there is no prec ct
	// between acts[1] and acts[3] anymore.  
//	forall(i in 1..n-1)
//	  endBeforeStart(acts[i], acts[i+1]);

	// Version 2: include all prec cts. Need to get transitive closure.
	// May also be expensive in case you have an extensive precedence graph.
//	forall(i in 1..n-1, j in i+1..n)
//	  endBeforeStart(acts[i], acts[j]);

	// Version 3: use activities that are always present upon which the precedence constraints
	// are defined + the "real" acts that are optional and for example could require
	// a certain resource.
	forall(i in 1..n) {
	  startAtStart(precActs[i], acts[i]);
	  endAtEnd(precActs[i], acts[i]);
	}	  
	
	forall(i in 1..n-1)
		endBeforeStart(precActs[i], precActs[i+1]);	   	  

}