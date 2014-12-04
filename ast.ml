type op = Add | Sub | Mult | Div | Eq | Neq | Less | Leq | Geq 

type animop = Left | Right | Up | Down

type expr =
          Literal of int
        | Id of string
        | Assign of string * expr
        | Binop of expr * op * expr
        | Animator of string * expr * animop * expr
        | Put of string * expr * string * expr * expr
        (*Note: we should pre-process put at into two separate move statements that calculates put into two move statements *)
        | Call of string

        
type stmt =
         Block of stmt list
       | Expr of expr
       | Return of expr
       | If of expr * stmt * stmt
       | Loop of expr * stmt

type func_decl = {
    fname: string; (* name of function *)
    locals: string list; (* list of local variables *)
    body: stmt list;
  
    }

type p_type = Int | Bool | Rect | Ellipse


type program = string list * func_decl list
