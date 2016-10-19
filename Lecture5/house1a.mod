using CP;

tuple Activity {
  key string nameAct;
  int sizeAct;
  int optAct;
}  

{Activity} Activities = ...;

dvar interval activities[act in Activities]
	optional(act.optAct)
	size act.sizeAct;

subject to
{}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}

