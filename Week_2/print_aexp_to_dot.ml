(* Defining the type for binary operations *)
type binop = Add | Sub | Mul | Div

(* Defining the type for arithmetic expressions *)
type expr = 
	| Int of int                       (* Integer constant *)
	| BinOp of binop * expr * expr     (* Binary operation *)

(* Function to generate and save the dot file *)
let print_aexp_to_dot_file (e: expr) (filename: string) : unit =
	let counter = ref 0 in
	let new_counter () = 
		let c = !counter in
		counter := c + 1;
		c
	in
	let rec print_expr (fmt: Format.formatter) (e: expr) : int =
		let c = new_counter () in
		match e with
		| Int i -> 
			Format.fprintf fmt "%d [label=\"Int %d\"];\n" c i;
			c
		| BinOp (op, e1, e2) ->
			let c1 = print_expr fmt e1 in
			let c2 = print_expr fmt e2 in
			Format.fprintf fmt "%d [label=\"%s\"];\n" c (match op with Add -> "Add" | Sub -> "Sub" | Mul -> "Mul" | Div -> "Div");
			Format.fprintf fmt "%d -> %d;\n" c c1;
			Format.fprintf fmt "%d -> %d;\n" c c2;
			c
	in
	let oc = open_out filename in
	let fmt = Format.formatter_of_out_channel oc in
	Format.fprintf fmt "digraph AST {\n";
	ignore (print_expr fmt e);
	Format.fprintf fmt "}\n";
	close_out oc

(* Test *)
let () = 
	let expr = BinOp (Add, Int 1, BinOp (Mul,  Int 2, Int 3)) in
	print_aexp_to_dot_file expr "aexp.dot"
