%{ open Ast %}

%token SEMICOLON LBRACE RBRACE LPAREN RPAREN EQ LTHAN GTHAN 
%token NOT TIMES NEQ LEQ GEQ AT BLOCK BLUE DOWN INT NOELSE
%token ELSE FALSE GREEN IF LEFT LOOP MAIN MOVE PUT ELLIPSE COMMA
%token RED RIGHT RUN TRUE UP WHILE ASSIGN BOOL RECT DRAWLOOP
%token <string> ID 
%token <int> LITERAL 

%nonassoc
%right ASSIGN
%left EQ NEQ
%left LTHAN GTHAN LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%left MOVE 


%start program
%type <Ast.program> program

%%
program:
                {[], []}        
     | program vdecl { ($2 :: fst $1), snd $1 }
     | program fdecl { fst $1, ($2 :: snd $1) }

fdecl:
    BLOCK ID LBRACE vdecl_list stmt_list RBRACE
        {
          {    
            fname = $2
            locals = List.rev $4;
            body = List.rev $5
          }
        }
vdecl_list:
                            { [] }
    | vdecl_list vdecl   {$2 :: $1}

vdecl:
      INT ID SEMICOLON  {Def(Int, $2, 0 )}
    | BOOL ID SEMICOLON {Def(Bool, $2, false)}
    | RECT ID SEMICOLON {Shapedef(Rect, $2, 10, 10, 255, 0, 0) }
    | ELLIPSE ID SEMICOLON {Shapedef(Ellipse, $2, 10, 10, 255, 0, 0)}     
    | INT ID ASSIGN expr SEMICOLON           { Def(Int, $2, $4}
    | BOOL ID ASSIGN expr SEMICOLON          { Def(Bool, $2, $4)}
    | RECT ID ASSIGN expr COMMA expr COMMA expr COMMA expr COMMA expr SEMICOLON   { Shapedef(Rect, $2, $4, $6, $8, $10, $12)}
    | ELLIPSE ID ASSIGN expr COMMA expr COMMA expr COMMA expr COMMA expr SEMICOLON { Shapedef(Ellipse, $2, $4, $6, $8, $10, $12)}

stmt_list:
                        { [] }
    | stmt_list stmt    { $2 :: $1 }


stmt:
      expr SEMICOLON                        { Expr($1)}
    | LBRACE stmt_list RBRACE               { Block(List.rev $2) }
    | IF LPAREN expr RPAREN stmt %prec NOELSE { If ($3, $5, Block([])) }
    | IF LPAREN expr RPAREN stmt ELSE stmt  { If($3, $5, $7) }
    | WHILE LPAREN expr RPAREN stmt         { While ($3, $5) }
    | RUN ID SEMICOLON                      { Run($2)}
    | DRAWLOOP LBRACE stmt_list RBRACE      { Draw(List.rev $3) }
    | PUT ID AT expr expr SEMICOLON         { Put($2, $4, $5) }
    | MOVE ID LEFT expr SEMICOLON           { Animator ($2, Left, $4) }
    | MOVE ID RIGHT expr SEMICOLON          { Animator ($2, Right, $4) }
    | MOVE ID UP expr SEMICOLON             { Animator ($2, Up, $4) }
    | MOVE ID DOWN expr SEMICOLON           { Animator ($2, Down, $4) }



expr:
   
      LITERAL                   { Literal($1) }
    | ID                        { Id($1) }
    | expr PLUS   expr          { Binop($1, Add,   $3) }
    | expr MINUS  expr          { Binop($1, Sub,   $3) }
    | expr TIMES  expr          { Binop($1, Mult,  $3) }
    | expr DIVIDE expr          { Binop($1, Div,   $3) }
    | expr EQ     expr          { Binop($1, Equal, $3) }
    | expr NEQ    expr          { Binop($1, Neq,   $3) }
    | expr LTHAN     expr          { Binop($1, Less,  $3) }
    | expr LEQ    expr          { Binop($1, Leq,   $3) }
    | expr GTHAN     expr          { Binop($1, Greater,  $3) }
    | expr GEQ    expr          { Binop($1, Geq,   $3) }
    | ID ASSIGN expr            { Assign($1, $3) }
    | LPAREN expr RPAREN        { $2 } 

     
