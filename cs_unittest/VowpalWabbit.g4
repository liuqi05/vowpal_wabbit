grammar VowpalWabbit;

number returns [float value] : NUMBER;

label_simple	: value=number (WS initial=number)? WS;

namespace		: '|' name=STRING? (WS feature)+ WS?;

feature			: index=(STRING | NUMBER) (':' x=number)?	# FeatureSparse
				| ':' x=NUMBER								# FeatureDense
				;

// needs more testing
tag				: ('`' STRING)? WS
				| STRING
				;

example			: label_simple tag? namespace (WS namespace)*;

start			: (example NEWLINE)* example (NEWLINE | EOF);

// greedy matching, if same length its matched in order
NUMBER			: INT | FLOAT;

fragment INT	: [+-]? [0-9]+ ([Ee] '-'? [0-9]+)?;
 
fragment FLOAT 	: [+-]? [0-9]* '.' [0-9]+ ([Ee] '-'? [0-9]+)?;

WS				: [ \t]+;

NEWLINE			: '\r'? '\n';

STRING			: ~([:| \t\r\n])+;
