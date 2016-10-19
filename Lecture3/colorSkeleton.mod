using CP;

int maxNrOfColors = 4;
range Colors = 1..maxNrOfColors;
string ColorNames[Colors] = ["red", "white", "blue", "green"]; 

dvar int Belgium in Colors;
dvar int France in Colors;
//+ Complete

subject to {  
	Belgium != France; 
// Complete
}

execute {
	writeln("Belgium:     ",  ColorNames[Belgium] );
	writeln("France:     ",  ColorNames[France] );
// Complete
}
