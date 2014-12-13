type op = Add | Sub | Mult | Div | Equals | Neq | Less | Leq | Geq | Greater

type animop = Left | Right | Up | Down

type p_type = Int | Bool

type s_type = Rect | Ellipse

type color = int * int * int

type expr =
          Literal of int 
        | Id of string
        | Vassign of string * expr
        | Sassign of string * expr * expr * color
        | Binop of expr * op * expr

type shape_decl = {
    stype: s_type;
    sname: string;
    x: expr;
    y: expr;
    scolor: color;
}



        
type vdecl = 
        Def of p_type * string * expr 

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
       | Vdec of vdecl
       | Sdec of shape_decl

type func_decl = {
    fname: string; (* name of function *)
    body: stmt list;
  
    }

type program = decl list * func_decl list
