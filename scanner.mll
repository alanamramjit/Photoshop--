{ open Parser}

rule token = parse
  [' ' '\t' '\r' '\n' ]  { token lexbuff }
|
