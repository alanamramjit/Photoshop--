type op = Add | Sub | Mult | Div | Eq | Neq | Less | Leq | Geq 

type animop = Left | Right | Up | Down

type expr =
          Literal of int
        | Id of string
        | Assign of string * expr
        | Binop of expr * op * expr
        | Animator of string * expr * animop * expr
        (*Note: we should pre-process put at into two separate move statements that calculates put into two move statements *)
        | Call of string

        
type stmt =
         Block of stmt list
       | 

type func_decl = {}

type program =
