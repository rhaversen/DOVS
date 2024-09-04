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

(* Function to evaluate an expression *)
let rec eval (e:expr) : int = 
	match e with
	| Int i -> i
	| BinOp (op, e1, e2) -> 
		let v1 = eval e1 in
		let v2 = eval e2 in
		match op with
		| Add -> v1 + v2
		| Sub -> v1 - v2
		| Mul -> v1 * v2
		| Div -> v1 / v2

(* Test cases *)
let test () = 
	let test_case (e:expr) (expected:int) : unit = 
		let result = eval e in
		if result = expected then
			Printf.printf "Test passed\n"
		else
			Printf.printf "Test failed\n"
	in
	test_case expression_01 5;
	test_case expression_02 6;
	test_case expression_03 8;
	test_case expression_04 6;;

(* Arithmetic expressions for task 3 *)
let task3_exp1 = BinOp (Add, Int 20, BinOp (Mul, Int 26, Int 58))
let task3_exp2 = BinOp (Mul, Int 5, BinOp (Div, Int 1, Int 10))
let task3_exp3 = BinOp (Sub, Int 31, Int 870)
let task3_exp4 = BinOp (Mul, BinOp (Add, BinOp (Div, Int 6, BinOp (Add, Int 10, Int 49)), Int 10), BinOp (Add, BinOp (Sub, BinOp (Mul, Int 70, Int 77), BinOp (Div, Int 12, Int 9)), Int 5))
let task3_exp5 = BinOp (Sub, BinOp (Div, Int 34, Int 72), BinOp (Div, Int 17, Int 46))

(* Function to run the evaluations for task 3 *)
let eval_asm () = 
	Printf.printf "Expression 1: %d\n" (eval task3_exp1);
	Printf.printf "Expression 2: %d\n" (eval task3_exp2);
	Printf.printf "Expression 3: %d\n" (eval task3_exp3);
	Printf.printf "Expression 4: %d\n" (eval task3_exp4);
	Printf.printf "Expression 5: %d\n" (eval task3_exp5);;
