(* Defining the type for binary operations *)
type binop = Add | Sub | Mul | Div

(* Defining the type for arithmetic expressions *)
type expr = 
  | Int of int                       (* Integer constant *)
  | BinOp of binop * expr * expr     (* Binary operation *)

(* Function to get operator string from binop type *)
let string_of_binop = function
  | Add -> "Add"
  | Sub -> "Sub"
  | Mul -> "Mul"
  | Div -> "Div"

(* Recursive function to print expression trees *)
let rec print_tree prefix last first = function
  | Int n -> 
      Printf.printf "%s%s%d\n" prefix (if last then "└── " else (if first then "" else "├── ")) n
  | BinOp (op, e1, e2) ->
      Printf.printf "%s%sBinOp %s\n" prefix (if last then "└── " else (if first then "" else "├── ")) (string_of_binop op);
      let new_prefix = prefix ^ (if last then "    " else (if first then "" else "│   ")) in
      print_tree new_prefix false false e1;
      print_tree new_prefix true false e2

(* Initiates tree printing *)
let print_expr_tree expr =
  print_tree "" false true expr;
  print_newline ();;

(* Test the function with a very complicated example *)
print_expr_tree (BinOp (Add, BinOp (Mul, Int 3, Int 4), BinOp (Div, Int 10, Int 2)));;
