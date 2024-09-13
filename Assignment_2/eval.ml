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

(* Function to evaluate binary operations *)
let eval_binop op v1 v2 =
  match op with
  | Add -> v1 + v2
  | Sub -> v1 - v2
  | Mul -> v1 * v2
  | Div -> v1 / v2

(* Function to handle user input *)
let eprog_input () = 
  Printf.printf "Please enter an integer: " ; read_line () |> int_of_string

(* Function to evaluate expressions *)
let rec eval_expr env expr =
  match expr with
  | Int n -> n
  | Var v -> List.assoc v env
  | BinOp (op, e1, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      eval_binop op v1 v2

(* Function to evaluate statements *)
let rec eval_stmts env stmts =
  match stmts with
  | [] -> env
  | Val (v, e) :: rest ->
      let value = eval_expr env e in
      eval_stmts ((v, value) :: env) rest
  | Input v :: rest ->
      let value = eprog_input () in
      eval_stmts ((v, value) :: env) rest

(* Function for evaluating expression programs *)
let eval (stmts, expr) =
  let env = eval_stmts [] stmts in
  eval_expr env expr;;


(* Test cases *)
let test () = 
  let test_case_no_input (p:eprog) (expected:int) : unit = 
    let result = eval p in
    if result = expected then
      Printf.printf "Test passed\n"
    else
      Printf.printf "Test failed: expected %d but got %d\n" expected result
  in
  let test_case_with_input (p:eprog) : unit =
    let result = eval p in
    Printf.printf "The result is: %d\n" result
  in

  (* Test cases with no input *)
  let eprog_01 = ([], BinOp (Add, Int 2, Int 3)) in
  let eprog_02 = ([], BinOp (Mul, Int 2, BinOp (Add, Int 1, Int 2))) in
  let eprog_03 = ([], BinOp (Sub, BinOp (Add, Int 10, Int 2), Int 4)) in

  (* Test cases with input *)
  let eprog_04 = ([Input "x"; Val ("y", BinOp (Add, Var "x", Int 2))], Var "y") in
  let eprog_05 = ([Input "a"; Input "b"; Val ("c", BinOp (Mul, Var "a", Var "b"))], Var "c") in

  (* Run tests without input *)
  test_case_no_input eprog_01 5;
  test_case_no_input eprog_02 6;
  test_case_no_input eprog_03 8;

  (* Run tests with input *)
  Printf.printf "For eprog_04, enter a value for x:\n";
  test_case_with_input eprog_04;

  Printf.printf "For eprog_05, enter values for a and b:\n";
  test_case_with_input eprog_05
;;
