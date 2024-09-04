open Eval
open PrettyPrinter

let () =
  Printf.printf "Running tests from Eval module:\n";
  Eval.test ();

  Printf.printf "Running tests from PrettyPrinter module:\n";
  PrettyPrinter.test ()