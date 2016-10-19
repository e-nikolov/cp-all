using CP;

tuple Activity {
  key string nameAct;
  int sizeAct;
}  

{Activity} Activities = ...;

dvar interval activities[act in Activities]
	size act.sizeAct;

subject to
{}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}
