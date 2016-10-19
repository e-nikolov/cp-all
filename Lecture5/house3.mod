using CP;

tuple Activity {
  key string nameAct;
  int sizeAct;
  int optAct;
}  

{Activity} Activities = ...;

{string} NameSet = {str | <str, sz, op> in Activities};

tuple Precedence {
	string predId;
	string succId;
}

{Precedence} Precedences 
	with predId in NameSet,
	     succId in NameSet = ...; 

dvar interval activities[act in Activities]
	optional(act.optAct)
	size act.sizeAct;

pwlFunction earlyMasonry = piecewise{-200->25;0}(25,0);
dexpr float earlinessMasonry = 
	startEval(activities[<"masonry">], earlyMasonry);

pwlFunction earlyCarpentry = piecewise{-300->75;0}(75,0);
dexpr float earlinessCarpentry = 
	startEval(activities[<"carpentry">], earlyCarpentry);

pwlFunction earlyCeiling = piecewise{-100->75;0}(75,0);
dexpr float earlinessCeiling = 
	startEval(activities[<"ceiling">], earlyCeiling);

pwlFunction lateMoving = piecewise{0->100;400}(100,0);
dexpr float latenessMoving = 
	endEval(activities[<"moving">], lateMoving);

execute {
	cp.param.Workers = 1;
}

minimize
  earlinessMasonry + 
  earlinessCarpentry + 
  earlinessCeiling + 
  latenessMoving;
subject to
{
  forall(p in Precedences) {
 		endOf(activities[<p.predId>]) <= startOf(activities[<p.succId>], 1000);
  }   
}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}