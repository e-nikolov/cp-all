using CP;

int n = 3;

dvar interval acts[1..n]
	optional
	size 10;

minimize
  max(i in 1..n) endOf(acts[i]);
subject to {

	sum(i in 1..n) presenceOf(acts[i]) >= 2;

	forall(i in 1..n-1)
	  endBeforeStart(acts[i], acts[i+1]);
}