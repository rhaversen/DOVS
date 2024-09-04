(* Defining the type for binary operations *)
type binop = Add | Sub | Mul | Div

(* Defining the type for arithmetic expressions *)
type expr 
	= Int of int                       (* Integer constant *)
	| BinOp of binop * expr * expr     (* Binary operation *)

(* Here are a few examples of values of type expr. *)
let expression_01 = Int 5                                         (* 5       *)
let expression_02 = BinOp (Add, Int 1, expression_01)             (* 1+5     *)
let expression_03 = BinOp (Mul, BinOp (Add, Int 2, Int 2), Int 2) (* (2+2)*2 *)
let expression_04 = BinOp (Add, Int 2, BinOp (Mul, Int 2, Int 2)) (* 2+2*2   *)

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

(* Test cases *)
let test () = 
  let test_case (e:expr) (expected:string) : unit = 
    let result = string_of_expr e in
    if result = expected then
      Printf.printf "Test passed\n"
    else
      Printf.printf "Test failed\n"
  in
  test_case expression_01 "5";
  test_case expression_02 "(1+5)";
  test_case expression_03 "((2+2)*2)";
  test_case expression_04 "(2+(2*2))"
