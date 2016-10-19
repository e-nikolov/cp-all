using CP;

tuple Activity {
  key string nameAct;
  int sizeAct;
  int optAct;
}  

{Activity} Activities = ...;

{string} NameSet = {str | <str, sz, op> in Activities};
//{string} NameSet = {act.nameAct | act in Activities};

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

minimize
  endOf(activities[<"moving">]);
subject to
{
  forall(p in Precedences) {
 		endOf(activities[<p.predId>]) <= startOf(activities[<p.succId>]);
  }   
}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}

