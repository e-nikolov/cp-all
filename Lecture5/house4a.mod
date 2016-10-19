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

dexpr int notDoingFacade =
	(1 - presenceOf(activities[<"facade">]))*1500;

dexpr int notDoingGarden =
	(1 - presenceOf(activities[<"garden">]))*1500;

execute {
	cp.param.Workers = 1;
}

minimize
  earlinessMasonry + 
  earlinessCarpentry + 
  earlinessCeiling + 
  latenessMoving +
  notDoingFacade +
  notDoingGarden;
subject to
{
  // To test that not doing garden indeed leads to a
  // worse solution.
  //!presenceOf(activities[<"garden">]);
  
  forall(p in Precedences) {
 		endBeforeStart(activities[<p.predId>], activities[<p.succId>]);
  }   
}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}