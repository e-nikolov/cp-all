using CP;

{string} ColorNames = ...;
range Colors = 0..card(ColorNames)-1;

{string} Countries = ...;

tuple Border {
	string country1;
	string country2; 
}  

{Border} Borders with country1 in Countries, country2 in Countries = ...;
dvar int color[Countries] in Colors;


// No assumption on colors being interchangeable.
dexpr int nrOfColors = sum(col in Colors) (count(color, col) > 0);

minimize
	nrOfColors;

subject to {
	// For all borders, the colors of the 2 countries on each side of the border are different.
	forall(b in Borders)
 	  color[b.country1] != color[b.country2];
}

execute {
	for(var c in Countries)
   		writeln(c, ": ", Opl.item(ColorNames, color[c]));
}
