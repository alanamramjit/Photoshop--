{ open Parser }

let letter = ['a'-'z' 'A' - 'Z']
let digit = ['0'-'9']
let identifier = (letter)(letter | digit)*


rule token = parse
  	[' ' '\t' '\r' '\n' ] { token lexbuf }
	| '~' 									{ comment lexbuf }
	| ';' 									{ SEMICOLON }
	| '{' 									{ LBRACE }
	| '}' 									{ RBRACE }
	| '(' 									{ LPAREN }
	| ',' 									{ COMMA }
	| ')' 									{ RPAREN }
	| '=' 									{ ASSIGN }
	| '<' 									{ LTHAN }
	| '>' 									{ GTHAN }
	| '!' 									{ NOT }
	| '*' 									{ TIMES }
	| '+'                                   { PLUS }
    | '-'                                   { MINUS }
    | "==" 									{ EQ }
	| "!=" 									{ NEQ }
	| "<=" 									{ LEQ }
	| ">=" 									{ GEQ }
	| ".x" 									{ GETX }
	| ".y" 									{ GETY }
	| ".width" 					       		{ WIDTH }
	| ".height" 				            { HEIGHT }
	| ".color" 						       	{ GETCOLOR }
	| "at" 									{ AT }
	| "block" 						        { BLOCK }
	| "blue" 								{ BLUE }
	| "bool" 								{ BOOL }
	| "down" 								{ DOWN }
	| "drawloop" 				        	{ DRAWLOOP }
	| "ellipse" 					       	{ ELLIPSE }
	| "else" 								{ ELSE }
	| "false" 					        	{ FALSE }
	| "green" 						        { GREEN }
	| "if" 									{ IF }
	| "int" 								{ INT }
	| "left" 								{ LEFT }
	| "main" 								{ MAIN }
	| "move" 								{ MOVE }
	| "put" 								{ PUT }
	| "rect" 								{ RECT }
	| "red" 								{ RED }
	| "right" 			        			{ RIGHT }
	| "run" 								{ RUN }
	| "true" 								{ TRUE }
	| "up" 									{ UP }
	| "while" 			        			{ WHILE }
	| identifier as lxm 	                { ID(lxm) } 
	| eof 									{ EOF }
	| digit+ as lxm 			            { LITERAL(int_of_string lxm) }
	| _ as char 					        { raise (Failure("illegal character " ^ Char.escaped char)) }

and comment = parse
	'~' 									{ token lexbuf }
	| _ 									{ comment lexbuf }
	| eof 									{ raise (Failure ("unclosed comment" )) }   
