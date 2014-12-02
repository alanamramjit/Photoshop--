%{ open Ast %}

%token SEMICOLON LBRACE RBRACE LPAREN RPAREN EQ LTHAN GTHAN 
%token NOT TIMES NEQ LEQ GEQ AT BLOCK BLUE BOOL DOWN ELLIPSE
%token ELSE FALSE GREEN IF INT LEFT LOOP MAIN MOVE PUT RECT
%token RED RIGHT RUN TRUE UP WHILE ID EOF LITERAL ASSIGN

(*assign operator precedence and associativity *)
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

    fdecl:
         BLOCK ID LBRACE vdecl_list stmnt_list RBRACE
{
    {    fname = $2;
        locals = List.rev $4;
        body = List.rev $5;
    }
}

vdecl_list:
        { [] }
       | vdecl_list vdecl {$2 :: $1}

vdecl:
       (* *)


 stmt_list:
                { [] }
    | stmt_list stmt    { $2 :: $1 }


stmt:
        expr SEMICOLON       { Expr($1)}
      | LBRACE stmt_list RBRACE { Block(List.rev $2) }
      | IF LPAREN expr RPAREN stmt %prec NOELSE { If ($3, $5, Block([])) }
      | IF LPAREN expr RPAREN stmt ELSE stmt    {If($3, $5, $7) }
      | WHILE LPAREN expr RPAREN stmt   {While ($3, $5) }]
      | RUN ID SEMICOLON { Run($2)}
      | DRAWLOOP LBRACE stmt_list RBRACE { Draw(List.rev $3) }



 expr:
     
        LITERAL          { Literal($1) }
      | ID               { Id($1) }
      | expr PLUS   expr { Binop($1, Add,   $3) }
      | expr MINUS  expr { Binop($1, Sub,   $3) }
      | expr TIMES  expr { Binop($1, Mult,  $3) }
      | expr DIVIDE expr { Binop($1, Div,   $3) }
      | expr EQ     expr { Binop($1, Equal, $3) }
      | expr NEQ    expr { Binop($1, Neq,   $3) }
      | expr LT     expr { Binop($1, Less,  $3) }
      | expr LEQ    expr { Binop($1, Leq,   $3) }
      | expr GT     expr { Binop($1, Greater,  $3) }
      | expr GEQ    expr { Binop($1, Geq,   $3) }
      | ID ASSIGN expr   { Assign($1, $3) }
      | LPAREN expr RPAREN { $2 }
      | PUT ID AT expr expr {Put($2, $4, $5)}
      | MOVE ID LEFT expr {Animator ($2, Left, $4)}
      | MOVE ID RIGHT expr {Animator ($2, Right, $4)}
      | MOVE ID UP expr {Animator ($2, Up, $4)}
      | MOVE ID DOWN expr {Animator ($2, Down, $4)}


     
