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

type semant_error 
  = Undeclared of varname 
  | Duplicate of varname

type semant_result
  = Ok
  | Error of semant_error list

(* A few examples with semantic errors *)

let eprog_01: eprog = (
      [ Val ("y", BinOp (Add, Var "x", Int 1)) ],
      Var "y")
(*
Undeclared variable: x

val y = (x+1)
return y
*)

let eprog_02: eprog = (
      [ Input "y"; Val ("y", Var "x") ],
      BinOp (Add, Var "y", Int 2))
(*
Duplicate variable: y
Undeclared variable: x

input y
let y = x
return y + 2 
*)

(* Function to perform semantic analysis *)
let semant ((stmts, expr) : eprog) : semant_result =
  let rec process_stmts stmts declared_vars errors =
    match stmts with
    | [] -> (declared_vars, errors)
    | stmt :: rest ->
        let (declared_vars', errors') =
          match stmt with
          | Input v ->
              let errors =
                if List.mem v declared_vars then Duplicate v :: errors else errors
              in
              (v :: declared_vars, errors)
          | Val (v, e) ->
              let errors = errors @ process_expr declared_vars e in
              let errors =
                if List.mem v declared_vars then Duplicate v :: errors else errors
              in
              (v :: declared_vars, errors)
        in
        process_stmts rest declared_vars' errors'
  and process_expr declared_vars e =
    match e with
    | Int _ -> []
    | Var v ->
        if List.mem v declared_vars then [] else [Undeclared v]
    | BinOp (_, e1, e2) ->
        process_expr declared_vars e1 @ process_expr declared_vars e2
  in
  let (declared_vars, errors) = process_stmts stmts [] [] in
  let errors = errors @ process_expr declared_vars expr in
  if errors = [] then Ok else Error errors

(* Function to print errors *)
let print_errors errs =
  List.iter (function
    | Undeclared v -> Printf.printf "Undeclared variable: %s\n" v
    | Duplicate v -> Printf.printf "Duplicate variable: %s\n" v
  ) errs

(* Testing the semantic analysis function *)
let test () =
  let test_program (prog_name, eprog) =
    Printf.printf "Testing %s:\n" prog_name;
    match semant eprog with
    | Ok -> print_endline "No errors"
    | Error errs ->
        print_endline "Errors found:";
        print_errors errs;
    print_endline ""
  in

  test_program ("eprog_01", eprog_01);
  test_program ("eprog_02", eprog_02)
