type op = Add | Sub | Mult | Div | Eq | Neq | Less | Leq | Geq 

type animop = Left | Right | Up | Down

type expr =
          Literal of int
        | Id of string
        | Assign of string * expr
        | Binop of expr * op * expr
        

        
type stmt =
         Block of stmt list
       | Expr of expr
       | Return of expr
       | If of expr * stmt * stmt
       | While of expr * stmt
       | Run of string
       | Animator of string * expr * animop * expr
       | Put of string * expr *  expr
       | Draw of stmt_list

type vdecl = 
        Def of p_type * string * expr 
      | Shapedef of s_type * expr * (expr, expr, expr) 

type func_decl = {
    fname: string; (* name of function *)
    locals: string list; (* list of local variables *)
    body: stmt list;
  
    }

type p_type = Int | Bool

type s_type = Rect | Ellipse


type program = string list * func_decl list
