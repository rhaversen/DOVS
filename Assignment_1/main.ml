open Eval
open PrettyPrinter
open Asm_example

let () =
  Printf.printf "Running tests from Eval module:\n";
  Eval.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from PrettyPrinter module:\n";
  PrettyPrinter.test ();
  Printf.printf "\n";

  Printf.printf "Printing the example assembly code:\n";
  Asm_example.printExample ()
