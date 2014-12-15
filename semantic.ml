open Ast

let op_to_string = function
	  Add -> "+"
	| Sub -> "-"
	| Mult -> "*"
	| Div -> "/"
	| Eq -> "=="
	| Neq -> "!="
	| Less -> "<"
	| Leq -> "<="
	| Geq -> ">="

