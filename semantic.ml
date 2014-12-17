open Ast

(* Returns a string representation of the given binary operation *)
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

(* Returns a string ID suffix for the given property *)
let string_of_prop = function
    X -> ".frame.x"
  | Y -> ".frame.y"
  | Width -> ".frame.width"
  | Height -> ".frame.height"
  | Color -> ".color"
  | Angle -> ".angle"

(* Returns a string for the given basic type *)
let string_of_type = function
    Int -> "int"
  | Bool -> "boolean"

(* Returns a string ID suffix for the given move direction *)
let string_of_direction = function
    Left -> ".frame.x -="
  | Right -> ".frame.x +="
  | Up -> ".frame.y -="
  | Down -> ".frame.y +="
  | Degoffset -> ".angle +="

let is_valid_rgb rgb =
  if rgb > 255 || rgb < 0
    then false
  else
    true

(* Returns a string for the given color *)
let string_of_color col =
  let (r, g, b) = col in
    if (is_valid_rgb r) && (is_valid_rgb g) && (is_valid_rgb b)
      then "new Color(" ^ string_of_int r ^ ", " ^ string_of_int g ^ ", " ^ string_of_int b ^ ")"
    else
      raise(Failure("Invalid color! Colors must be one of: red, green, blue, or (0-255, 0-255, 0-255)"))

(* Returns a string identifier for the given shape type *)
let string_of_stype = function
    Rect -> "Shape.Type.RECTANGLE"
  | Ellipse -> "Shape.Type.ELLIPSE"

(* Returns a string for the given expression *)
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

(* Returns a string for the given variable declaration *)
let string_of_vdecl = function 
    Def(ty, id, ex) -> string_of_type ty ^" " ^ id ^ " = " ^ string_of_expr ex ^ ";\n"
  | Shape(shape_defn) -> "Shape " ^ shape_defn.sname ^ " = new Shape(new Rectangle(" ^ string_of_expr shape_defn.x ^ ", " ^ string_of_expr shape_defn.y ^ ", " ^ string_of_expr shape_defn.w ^ ", " ^ string_of_expr shape_defn.h ^ "), " ^ string_of_color shape_defn.scolor ^ ", " ^ string_of_stype shape_defn.stype ^ ");\n"

(* Returns a string for the given statement *)
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
  | Print(str) -> "System.out.println("^str^");"
  | Background(color) -> "setBackground(" ^ string_of_color color ^ ");"

(* Returns a string add statement for the given v_decl()->Shape *)
 let string_of_add = function
  Shape(shape_defn) -> "shapes.add(" ^ shape_defn.sname ^ ");\n"
  | Def(_, _, _) -> ""

(* Returns a string for the given function declaration *)
let string_of_func f_decl = "public void " ^ f_decl.fname ^ "() {\n\t" ^ String.concat "\n\t" (List.map string_of_stmt f_decl.body) ^ "\n}"

(* Returns a single string with the program's contents *)
let check_program (gl, funs) =
  ignore(List.map string_of_vdecl (List.rev gl));
  ignore(List.map string_of_func (List.rev funs));
