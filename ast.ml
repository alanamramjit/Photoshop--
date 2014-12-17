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
  | Boolean of string
        
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
  | If of expr * stmt * stmt
  | While of expr * stmt
  | Run of string
  | Animator of string * animop * expr
  | Put of string * expr *  expr
  | Vdecl of v_decl

type f_decl =
         {
                fname: string; (* name of function *)
                body: stmt list;
         }


type program = v_decl list * f_decl list

type prog_funcs =
     Var of v_decl
   | Fun of f_decl

let string_of_op = function
    Add -> "+"
  | Sub -> "-"
  | Mult -> "*"
  | Div -> "/"
  | Equals -> "=="
  | Neq -> "!="
  | Less -> "<"
  | Leq -> "<="
  | Greater -> ">"
  | Geq -> ">="

let string_of_prop = function
    X -> ".frame.x"
  | Y -> ".frame.y"
  | Width -> ".frame.width"
  | Height -> ".frame.height"
  | Color -> ".color"

let string_of_type = function
    Int -> "int"
  | Bool -> "boolean"

let string_of_direction = function
    Left -> ".frame.x -="
  | Right -> ".frame.x +="
  | Up -> ".frame.y -="
  | Down -> ".frame.y +="


let string_of_color col =
  let (r, g, b) = col in
    "new Color(" ^ string_of_int r ^ ", " ^ string_of_int g ^ ", " ^ string_of_int b ^ ")"

let string_of_stype = function
    Rect -> "Shape.Type.RECTANGLE"
  | Ellipse -> "Shape.Type.ELLIPSE"

let rec string_of_expr = function
    Literal(l) -> string_of_int l
  | Id(id) -> id
  | Boolean(b) -> b 
  | Binop(e1, op, e2) ->
      string_of_expr e1 ^ " " ^ string_of_op op ^ " " ^ string_of_expr e2
  | Vassign(e1, e2) -> e1 ^ " = " ^ string_of_expr e2
  | Rgb(col) -> string_of_color col
  | Get(id, prop) -> id ^ string_of_prop prop
  | Set(id, prop, ex) -> id ^ string_of_prop prop ^ " = " ^ string_of_expr ex

let string_of_vdecl = function 
    Def(ty, id, ex) -> string_of_type ty ^" " ^ id ^ " = " ^ string_of_expr ex ^ ";\n"
  | Shape(shape_defn) -> "Shape " ^ shape_defn.sname ^ " = new Shape(new Rectangle(" ^ string_of_expr shape_defn.x ^ ", " ^ string_of_expr shape_defn.y ^ ", " ^ string_of_expr shape_defn.w ^ ", " ^ string_of_expr shape_defn.h ^ "), " ^ string_of_color shape_defn.scolor ^ ", " ^ string_of_stype shape_defn.stype ^ ");\n"

let rec string_of_stmt = function
    Expr(ex) -> string_of_expr ex ^";"
  | Block(s) -> "{\n"^String.concat "\n" (List.map string_of_stmt s) ^ "}\n"
  | If(ex, s, Block([])) -> "if (" ^ string_of_expr ex ^")\n" ^string_of_stmt s
  | If(ex, s1, s2) -> "if (" ^ string_of_expr ex ^")\n"^string_of_stmt s1 ^ "else\n" ^ string_of_stmt s2
  | While(ex, s) -> "while (" ^ string_of_expr ex ^")\n"^ string_of_stmt s 
  | Run(id) -> id^"();"
  | Put(id, ex1, ex2) -> id ^ ".frame.x = " ^ string_of_expr ex1 ^ "; " ^ id ^ ".frame.y = " ^ string_of_expr ex2 ^ ";"
  | Animator(id, dir, ex) -> id ^ string_of_direction dir ^ string_of_expr ex ^ ";"
  | Vdecl(var) -> string_of_vdecl var ^ ";"

 let string_of_add = function
  Shape(shape_defn) -> "shapes.add(" ^ shape_defn.sname ^ ");\n"
  | Def(_, _, _) -> ""
(*
let check_program program = 
  let (shape_defs, func_defs, drawloop) = 
    List.fold_left (
      fun (shape_defs, func_defs, drawloop) prog ->
        (match prog with
          Fun(func) -> ("", "", "") (* let func_defs = func_defs ^ string_of_fdecl func in (shape_defs, func_defs, drawloop) *)
          | Var(var) -> let shape_defs = shape_defs ^ string_of_vdecl var ^ ";" in (shape_defs, func_defs, drawloop)
        )
    ) ("", "", "") program
  in (shape_defs, func_defs, drawloop)
*)

let string_of_func f_decl = "public void " ^ f_decl.fname ^ "() {\n\t" ^ String.concat "\n\t" (List.map string_of_stmt f_decl.body) ^ "\n}"

let program_string (gl, funs) =
  String.concat "" (List.map string_of_vdecl gl) ^"\n" ^ String.concat "\n" (List.map string_of_func funs) ^ "\n" 

let program_string_split (gl, funs) = 
  (String.concat "" (List.map string_of_vdecl gl), String.concat "" (List.map string_of_add gl), String.concat "\n" (List.map string_of_func funs) ^ "\n")
