open PrettyPrinter
open SemanticAnalysis

let () =
  Printf.printf "Running tests from PrettyPrinter module:\n";
  PrettyPrinter.test ();
  Printf.printf "\n";

  Printf.printf "Running tests from SemanticAnalysis module:\n";
  SemanticAnalysis.test ();
