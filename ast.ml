type op = Add | Sub | Mult | Div | Eq | Neq | Less | Leq | Geq | Greater
type animop = Left | Right | Up | Down

type p_type = Int | Bool

type s_type = Rect | Ellipse

type color = int * int * int

type expr =
          Literal of int 
        | Id of string
        | Assign of string * expr
        | Binop of expr * op * expr
        
type vdecl = 
        Def of p_type * string * expr 
      | Shapedef of s_type * string * color 

type stmt =
         Block of stmt list
       | Expr of expr
       | Return of expr
       | If of expr * stmt * stmt
       | While of expr * stmt
       | Run of string
       | Animator of string * animop * expr
       | Put of string * expr *  expr
       | Draw of stmt list

type func_decl = {
    fname: string; (* name of function *)
    body: stmt list;
  
    }

type program = vdecl list * func_decl list
