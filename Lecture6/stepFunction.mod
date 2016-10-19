using CP;
 
stepFunction w = 
	stepwise{100->20;60->30;100};

dvar interval act 
	size 14 
	intensity w;

maximize
  lengthOf(act);
subject to {
  startOf(act) == 10;    
}    