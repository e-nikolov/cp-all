using CP;

int n = ...;
int profit[i in 1..n] = ...;

dvar interval A[i in 1..n] 
	optional 
	in (i-1)*5..i*5
	size 5;

execute {
	cp.param.Workers = 1;
}

maximize
	sum(i in 1..n) presenceOf(A[i])*profit[i];
subject to {
	forall(i in 1..n-1) {
		endBeforeStart(A[i],A[i+1]);
		presenceOf(A[i+1]) => presenceOf(A[i]);
	}
}
