type op = Add | Sub | Mult | Div | Equals | Neq | Less | Leq | Geq | Greater

type animop = Left | Right | Up | Down

type s_type = Rect | Ellipse

type sdesc = Width | Height | X | Y | Color

type color = int * int * int

type expr =
          Literal of int 
        | Id of string
        | Vassign of string * expr
        | Binop of expr * op * expr
        | Get of string * sdesc
        | Set of string * sdesc * expr
        | Rgb of (color)
        
type p_type = Int | Bool 
      
type shape =   {
    stype: s_type;
    sname: string;
    x: expr;
    y: expr;
    w: expr;
    h: expr;
    scolor: color;
   }


type v_decl =
          Shape of shape
        | Def of p_type * string * expr
        

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
       | Vdec of v_decl
      

type func_decl = {
    fname: string; (* name of function *)
    body: stmt list;
  
    }

type program = v_decl list * func_decl list

(*
let string_of_op = function
  Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Eq -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | Id(id) -> id
  | Boolean(b) -> if b then 1 else 0
  | Binop(ex1, op, ex2) ->
      string_of_expr e1 ^ " " ^ (string_of_op op) ^ " " ^ string_of_expr e2
  | Assign(ex1, ex2) -> string_of_expr e1 ^ " = " ^ string_of_expr e2

let string_of_vdecl = function 
    Def(ty, id, ex) -> ty ^ " = " ^ string_of_expr ex

let string_of_shape_decl = function    
    (* Depends on Graphics library we choose *)
  | Shapedef(ty, id, ex1, ex2, (r, g, b)) -> 


let rec string_of_stmt = function
    Expr(ex) -> ex * " ; "
  | Block(s) -> "{\n"^String.concat"" (List.map string_of_stmt s) ^ "}\n"
  | If(ex, s, Block([])) -> "if (" ^ string_of_expr ex ^")\n" ^string_of_stmt s
  | If(ex, s1, s2) -> "if (" ^ string_of_expr ex ^")\n"^string_of_stmt s1 "else\n" ^ string_of_stmt s2
  | While(ex, s) -> "while (" ^ string_of_expr ex ^")\n" string_of_stmt s 
  | Run(id) -> id^"();"
  (* Graphics library dependency *)
  | Draw(stmt) -> 
  | Put(id, ex1, ex2) ->
  | Animator(id, dir, ex) ->
*)
