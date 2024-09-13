open X86

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

(* Helper function to calculate stack offset for each variable *)
let offset_of_var v env =
  try List.assoc v env
  with Not_found -> failwith ("Undeclared variable: " ^ v)

(* Compile a binary operation *)
let compile_binop op =
  let open Asm in
  match op with
  | Add -> Addq
  | Sub -> Subq
  | Mul -> Imulq
  | Div -> Idivq

(* Compile an expression *)
let rec compile_expr env = 
  let open Asm in
  function
  | Int n ->
      [ Movq, [ Imm (Lit n); ~%Rax ] ]  (* Load immediate integer into RAX *)
  | Var v ->
      let offset = offset_of_var v env in
      [ Movq, [ Ind3 (Lit offset, Rbp); ~%Rax ] ]  (* Load variable from stack into RAX *)
  | BinOp (op, e1, e2) ->
      let code1 = compile_expr env e1 in
      let code2 = compile_expr env e2 in
      code1 @
      [ Pushq, [ ~%Rax ] ] @   (* Push result of e1 onto stack *)
      code2 @
      [ Popq, [ ~%Rbx ];       (* Pop result of e1 into RBX *)
        (compile_binop op, [ ~%Rbx; ~%Rax ]) ]  (* Apply binary operation *)

(* Compile a statement *)
let rec compile_stmt env offset = 
  let open Asm in
  function
  | Val (v, e) ->
      let expr_code = compile_expr env e in
      let new_offset = offset - 8 in
      let env' = (v, new_offset) :: env in
      expr_code @
      [ Movq, [ ~%Rax; Ind3 (Lit new_offset, Rbp) ] ], env', new_offset
  | Input v ->
      let new_offset = offset - 8 in
      let env' = (v, new_offset) :: env in
      [ Callq, [ ~$$"read_integer" ];
        Movq, [ ~%Rax; Ind3 (Lit new_offset, Rbp) ] ], env', new_offset

(* Compile the entire program *)
let eprog_to_x86 (stmts, expr) : prog =
  let open Asm in
  let prologue =
    [ Pushq, [Reg Rbp];                        (* Set up stack frame *)
      Movq, [Reg Rsp; Reg Rbp];                (* Move stack pointer to base pointer *)
      Subq, [Imm (Lit 64); Reg Rsp] ]          (* Reserve space for locals and intermediates *)
  in
  let epilogue =
    [ Addq, [Imm (Lit 64); Reg Rsp];          (* Clean up stack *)
      Popq, [Reg Rbp];                        (* Restore base pointer *)
      Retq, [] ]                              (* Return from function *)
  in
  let rec compile_stmts env offset = function
    | [] -> ([], env, offset)
    | stmt :: rest ->
        let code, env', new_offset = compile_stmt env offset stmt in
        let rest_code, final_env, final_offset = compile_stmts env' new_offset rest in
        (code @ rest_code, final_env, final_offset)
  in
  let stmt_code, env, offset = compile_stmts [] 0 stmts in
  let expr_code = compile_expr env expr in
  let print_code =
    [ Movq, [Reg Rax; Reg Rdi];             (* Move result to be printed *)
      Callq, [Imm (Lbl "print_int")] ]      (* Call print_int to output the result *)
  in
  let instructions = prologue @ stmt_code @ expr_code @ print_code @ epilogue in
  [ { lbl = "main"; global = true; asm = Text instructions } ]

(* Test cases *)
let test () =
  (* Function to compile eprog and print assembly code *)
  let print_assembly (p: eprog) : unit =
    let asm_prog = eprog_to_x86 p in
    let asm_code = string_of_prog asm_prog in
    print_endline asm_code
  in

  (* Test cases *)
  let eprog_01 = ([], BinOp (Add, Int 2, Int 3)) in
  let eprog_02 = ([], BinOp (Mul, Int 2, BinOp (Add, Int 1, Int 2))) in
  let eprog_03 = ([], BinOp (Sub, BinOp (Add, Int 10, Int 2), Int 4)) in

  (* Run tests *)
  print_endline "Assembly code for eprog_01:";
  print_assembly eprog_01;

  print_endline "\nAssembly code for eprog_02:";
  print_assembly eprog_02;

  print_endline "\nAssembly code for eprog_03:";
  print_assembly eprog_03;
;;
