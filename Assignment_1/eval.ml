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
	test_case expression_04 6
