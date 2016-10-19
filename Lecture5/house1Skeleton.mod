using CP;

tuple Activity {
  key string nameAct;
  int sizeAct;
  int optAct;
}  

{Activity} Activities = ...;
//range ActivityRange = 1..card(Activities);

// declare interval variables

dvar interval activities[a in Activities]
	optional(a.optAct) 
	size a.sizeAct;

subject to
{
	

}

execute {
  for(var act in Activities)
  	writeln(activities[act]);
}
