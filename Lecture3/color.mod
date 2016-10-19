using CP;

int maxNrOfColors = 4;
range Colors = 1..maxNrOfColors;
string ColorNames[Colors] = ["red", "white", "blue", "green"]; 

dvar int Belgium in Colors;
dvar int Denmark in Colors;
dvar int France in Colors;
dvar int Germany in Colors;
dvar int Luxembourg in Colors;
dvar int Netherlands in Colors;

subject to {  
	Belgium != France; 
	Belgium != Germany; 
	Belgium != Netherlands; 
	Belgium != Luxembourg; 
	Denmark != Germany;
	France != Germany; 
	France != Luxembourg; 
	Germany != Luxembourg; 
	Germany != Netherlands;
}

execute {
	writeln("Belgium:     ",  ColorNames[Belgium]);
	writeln("Denmark:     ",  ColorNames[Denmark]);
	writeln("France:      ",  ColorNames[France]);   
	writeln("Germany:     ",  ColorNames[Germany]);
	writeln("Luxembourg:  ",  ColorNames[Luxembourg]);
	writeln("Netherlands: ",  ColorNames[Netherlands]);
}
