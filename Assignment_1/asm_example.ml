open X86

let asm_example =
   let open Asm in                  (* Open Asm module locally; this brings
                                       the helper functions from that module 
                                       into the local scope *)
    [ gtext "example"               (* Global label *)
       [ (Movq, [~$ 2023; ~% Rax])    (* Store 23 in register %rax. 
                                       This is the register we must use 
                                       for returning values from a function
                                       according to System V ABI *)
       ; (Retq, [])                 (* Return instruction *)
    ]]

let printExample () = Printf.printf "%s\n" (string_of_prog asm_example)