using CP;
 
stepFunction w = 
	stepwise{100->20;60->30;100};

dvar interval act 
	size 14 
	intensity w;

execute {
	cp.param.Workers = 1;
}

subject to {
  startOf(act) == 10;    
}

main {
  thisOplModel.generate();
  cp.startNewSearch();
  var k = 1;
  while (cp.next()) {
    writeln("yes ", k);
    k = k + 1; 
    thisOplModel.postProcess();
  }
}

execute {
	writeln(act);
}