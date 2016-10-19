using CP;

int n = ...;

int nsqr = n*n;

range R = 1..n;

int input[R][R] = ...;
dvar int square[R][R] in 1..nsqr;

//dvar int magicSum;

//dexpr int magicSum = sum(i in R) (square[i][i]);

dexpr int magicSum = (n*(n*n+1)) div 2;

// something


subject to {

 	allDifferent(square);
 	
 	forall(i in R)
 	  forall(j in R)
 	    if(input[i][j] != 0)
 	    	input[i][j] == square[i][j];
 	
// 	magicSum == 10;
 	
 	forall(i in R) sum(j in R) (square[i][j]) == magicSum;
 	
 	forall(j in R) sum(i in R) (square[i][j]) == magicSum;
 	
 	sum(i in R) (square[i][i]) == magicSum;
 	
 	sum(i in R) (square[n + 1 - i][i]) == magicSum; 

//
// 	forall(i in R) {
// 		sum()	 	
// 	}
 	
 	  
// something else

}  