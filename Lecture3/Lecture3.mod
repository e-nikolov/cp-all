/*********************************************
 * OPL 12.6.3.0 Model
 * Author: enikolov
 * Creation Date: 13 Sep 2016 at 15:17:08
 *********************************************/

using CP;

dvar int x in 0..4;
dvar int y in 0..5; 

minimize
	x + y;
subject to {
	x > 1;
	x * y >= 15;
}
 