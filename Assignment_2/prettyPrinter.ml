(* Defining the type for binary operations *)
type binop =
  | Add | Sub | Mul | Div

type varname = string                (* variable names are strings *)

(* Defining the type for arithmetic expressions *)
type expr =
  | Int of int                       (* Integer constant *)
  | BinOp of binop * expr * expr     (* Binary operation *)
  | Var of varname                   (* Variable lookup  *)


(* Defining the type of statements *)  
type estmt = 
  | Val of varname * expr            (* Binding variable to a value *)
  | Input of varname                 (* Input statement *)

(* Expression program is a list of statements 
   followed by an expression *) 
type eprog = estmt list * expr

(* Here are a few examples of values of type expr. *)
let eprog_01: eprog = (
      [ Input "x" ; Val ("y", BinOp (Add, Var "x", Int 1)) ],
      BinOp (Add, Var "x", Var "y"))
(*
input x
val y = (x+1)
return (x+y)
*)

let eprog_02: eprog = (
      [ Val ("x", Int 5) ; Val ("y", BinOp (Add, Var "x", Int 1)) ],
      BinOp (Add, Var "x", Var "y"))
(*
val x = 5
val y = (x+1)
return (x+y)
*)

let eprog_03: eprog = (
      [ Input "x" ; Val ("y", BinOp (Div, Var "x", Int 2)) ],
      BinOp (Mul, Var "x", Var "y"))
(*
input x
val y = (x/2)
return (x*y)
*)

(* Function to pretty-print an expression *)
let rec string_of_expr = function
  | Int i -> string_of_int i
  | BinOp (op, e1, e2) ->
      "(" ^ (string_of_expr e1) ^
      (match op with
       | Add -> "+"
       | Sub -> "-"
       | Mul -> "*"
       | Div -> "/") ^
      (string_of_expr e2) ^ ")"
  | Var v -> v

(* Function to pretty-print an expression program *)
let rec string_of_eprog = function
  | ([], e) -> "return " ^ (string_of_expr e)
  | (Val (v, e) :: rest, e') -> "val " ^ v ^ " = " ^ (string_of_expr e) ^ "\n" ^ (string_of_eprog (rest, e'))
  | (Input v :: rest, e) -> "input " ^ v ^ "\n" ^ (string_of_eprog (rest, e))

(* Test cases *)
let test () = 
  let test_case (eprog: eprog) (expected:string) : unit = 
    let result = string_of_eprog eprog in
    if result = expected then
      Printf.printf "Test passed\n"
    else
      Printf.printf "Test failed\n"
  in
  test_case eprog_01 "input x\nval y = (x+1)\nreturn (x+y)";
  test_case eprog_02 "val x = 5\nval y = (x+1)\nreturn (x+y)";
  test_case eprog_03 "input x\nval y = (x/2)\nreturn (x*y)";;
