open PrettyPrinter
open SemanticAnalysis
open Eval
open AsmTask

let () =
  Printf.printf "Running tests from PrettyPrinter module:\n";
  PrettyPrinter.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from SemanticAnalysis module:\n";
  SemanticAnalysis.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from Eval module:\n";
  Eval.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from AsmTask module:\n";
  AsmTask.test ()