{ open Parser}

let letter = ['a'-'z' 'A' - 'Z']
let digit = ['0'-'9']
let identifier = (letter)(letter | digit)*


rule token = parse
  [' ' '\t' '\r' '\n' ]  { token lexbuff }
| '(''*' { LCOMMENT}
| '*'')' { RCOMMENT}
| ';' { SEMICOLON }
| '{' { LBRACE }
| '}' { RBRACE }
| '=' { EQUALS }
| '<' { LTHAN }
| '>' { GTHAN }
| '!' { NOT }
| digit { DIGIT }
| "at" { AT }
| "block" { BLOCK }
| "blue" { BLUE}
| "bool" { BOOL }
| "down" { DOWN }
| "ellipse" { ELLIPSE }
| "else" { ELSE }
| "false" { FALSE }
| "green" { GREEN }
| "if" { IF }
| "int" { INT }
| "left" { LEFT }
| "loop" { LOOP }
| "main" { MAIN }
| "move" { MOVE }
| "put" { PUT }
|  "rect" { RECT }
| "red" { RED }
| "right" { RIGHT }
| "run" { RUN }
| "true" { TRUE }
| "up" { UP }
| identifier { ID } 


