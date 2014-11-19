%{ open Ast %}

%token SEMICOLON LBRACE RBRACE LPAREN RPAREN EQ LTHAN GTHAN 
%token NOT TIMES NEQ LEQ GEQ AT BLOCK BLUE BOOL DOWN ELLIPSE
%token ELSE FALSE GREEN IF INT LEFT LOOP MAIN MOVE PUT RECT
%token RED RIGHT RUN TRUE UP WHILE ID EOF LITERAL ASSIGN

(*assign operator precedence and associativity *)
%nonassoc
%right ASSOGM
%left EQ NEQ
%left LTHAN GTHAN LEQ GEQ
%left PLUS MINUS
%left TIMES DIVIDE
%left MOVE 


%start program
%type <Ast.program> program

%%


