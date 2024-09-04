open Eval
open PrettyPrinter
open AsmTask

let () =
  Printf.printf "Running tests from Eval module:\n";
  Eval.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from PrettyPrinter module:\n";
  PrettyPrinter.test ();
  Printf.printf "\n";
  
  Printf.printf "Printing the assembly code for task 3:\n";
  AsmTask.print_asm ();

  Printf.printf "Printing the evaluation of the assembly code for task 3:\n";
  Eval.eval_asm ()