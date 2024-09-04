open X86

let task3_asm =
  let open Asm in
  [ gtext "task3_exp1"  (* 20 + (26 * 58) *)
      [ (Movq, [~$ 26; ~% Rax])
      ; (Imulq, [~$ 58; ~% Rax])
      ; (Addq, [~$ 20; ~% Rax])
      ; (Pushq, [~% Rbp])               (* Stack alignment before call *)
      ; (Movq, [~% Rax; ~% Rdi])        (* Pass the result to %rdi *)
      ; (Callq, [~$$ "print_int"])      (* Call the print_int function *)
      ; (Popq, [~% Rbp])                (* Stack re-alignment *)
      ; (Movq, [~$ 0; ~% Rax])          (* Return 0 to indicate normal exit *)
      ; (Retq, [])
      ]
  ; gtext "task3_exp2"  (* 5 * (1 / 10) *)
      [ (Movq, [~$ 1; ~% Rax])          (* Move the value 1 into the Rax register *)
      ; (Movq, [~$ 10; ~% Rbx])         (* Move the value 10 into the Rbx register *)
      ; (Cqto, [])                      (* Sign extend Rax into Rdx:Rax for division *)
      ; (Idivq, [~% Rbx])               (* Divide Rdx:Rax by the value in Rbx (10) *)
      ; (Imulq, [~$ 5; ~% Rax])         (* Multiply the value in Rax by 5 *)
      ; (Pushq, [~% Rbp])               (* Push the value of the base pointer onto the stack *)
      ; (Movq, [~% Rax; ~% Rdi])        (* Move the value in Rax to the Rdi register *)
      ; (Callq, [~$$ "print_int"])      (* Call the print_int function *)
      ; (Popq, [~% Rbp])                (* Pop the top value from the stack into Rbp *)
      ; (Movq, [~$ 0; ~% Rax])          (* Move the value 0 into the Rax register *)
      ; (Retq, [])                      (* Return from the function *)
      ]
  ; gtext "task3_exp3"  (* 31 - 870 *)
      [ (Movq, [~$ 31; ~% Rax])         (* Move the value 31 into the Rax register *)
      ; (Subq, [~$ 870; ~% Rax])        (* Subtract the value 870 from the value in Rax *)
      ; (Pushq, [~% Rbp])               (* Push the value of the base pointer onto the stack *)
      ; (Movq, [~% Rax; ~% Rdi])        (* Move the value in Rax to the Rdi register *)
      ; (Callq, [~$$ "print_int"])      (* Call the print_int function *)
      ; (Popq, [~% Rbp])                (* Pop the top value from the stack into Rbp *)
      ; (Movq, [~$ 0; ~% Rax])          (* Move the value 0 into the Rax register *)
      ; (Retq, [])                      (* Return from the function *)
      ]
  ; gtext "task3_exp4"  (* (6 / (10 + 49) + 10) * ((70 * 77) - (12 / 9) + 5) *)
      [ (Movq, [~$ 10; ~% Rax])         (* Load 10 into RAX *)
      ; (Addq, [~$ 49; ~% Rax])         (* Add 49 to RAX => RAX = 59 *)
      ; (Movq, [~$ 6; ~% Rbx])          (* Load 6 into RBX *)
      ; (Cqto, [])                      (* Extend RBX to RDX:RBX for IDIVQ *)
      ; (Idivq, [~% Rax])               (* Divide RBX (6) by RAX (59), RAX = 0 as result of division *)
      ; (Addq, [~$ 10; ~% Rax])         (* Add 10 to RAX => RAX = 10, completes left expression of multiplication *)
      ; (Pushq, [~% Rax])               (* Push left part of multiplication onto stack *)

      ; (Movq, [~$ 70; ~% Rax])         (* Load 70 into RAX *)
      ; (Imulq, [~$ 77; ~% Rax])        (* Multiply RAX by 77, RAX = 5390 *)
      ; (Pushq, [~% Rax])               (* Push the result (5390) onto the stack to use later *)
      ; (Movq, [~$ 12; ~% Rbx])         (* Load 12 into RBX *)
      ; (Movq, [~$ 9; ~% Rcx])          (* Load 9 into RCX *)
      ; (Cqto, [])                      (* Sign extend RBX into RDX:RBX *)
      ; (Idivq, [~% Rcx])               (* Divide RBX (12) by RCX (9), RAX = 1 *)
      ; (Popq, [~% Rbx])                (* Pop 5390 off stack into RBX *)
      ; (Subq, [~% Rax; ~% Rbx])        (* Subtract RAX (1) from RBX (5390), RBX = 5389 *)
      ; (Addq, [~$ 5; ~% Rbx])          (* Add 5 to RBX, RBX = 5394 *)

      ; (Popq, [~% Rax])                (* Pop the left expression result (10) off stack into RAX *)
      ; (Imulq, [~% Rbx; ~% Rax])       (* Multiply RBX (5394) by RAX (10), RAX = 53940 *)

      ; (Pushq, [~% Rbp])               (* Save base pointer *)
      ; (Movq, [~% Rax; ~% Rdi])        (* Move RAX (final result 53940) to RDI for function call *)
      ; (Callq, [~$$ "print_int"])      (* Call print function to print RAX, which is 53940 *)
      ; (Popq, [~% Rbp])                (* Restore base pointer *)
      ; (Movq, [~$ 0; ~% Rax])          (* Set RAX to 0 for return *)
      ; (Retq, [])                      (* Return from the function *)
      ]
  ; gtext "task3_exp5"  (* (34 / 72) - (17 / 46) *)
      [ (Movq, [~$ 34; ~% Rax])         (* Move the value 34 into the Rax register *)
      ; (Movq, [~$ 72; ~% Rbx])         (* Move the value 72 into the Rbx register *)
      ; (Cqto, [])                      (* Sign extend Rax into Rdx:Rax for division *)
      ; (Idivq, [~% Rbx])               (* Divide Rdx:Rax by the value in Rbx (72) *)
      ; (Pushq, [~% Rax])               (* Push the result (Rax) onto the stack *)
      ; (Movq, [~$ 17; ~% Rax])         (* Move the value 17 into the Rax register *)
      ; (Movq, [~$ 46; ~% Rbx])         (* Move the value 46 into the Rbx register *)
      ; (Cqto, [])                      (* Sign extend Rax into Rdx:Rax for division *)
      ; (Idivq, [~% Rbx])               (* Divide Rdx:Rax by the value in Rbx (46) *)
      ; (Popq, [~% Rbx])                (* Pop the top value from the stack into Rbx *)
      ; (Subq, [~% Rax; ~% Rbx])        (* Subtract the value in Rax from Rbx *)
      ; (Pushq, [~% Rbp])               (* Push the value of the base pointer onto the stack *)
      ; (Movq, [~% Rbx; ~% Rdi])        (* Move the result (Rbx) to the Rdi register *)
      ; (Callq, [~$$ "print_int"])      (* Call the print_int function *)
      ; (Popq, [~% Rbp])                (* Pop the top value from the stack into Rbp *)
      ; (Movq, [~$ 0; ~% Rax])          (* Move the value 0 into the Rax register *)
      ; (Retq, [])                      (* Return from the function *)
      ]
  ]

(* Print the assembly code to standard output *)
let print_asm () = Printf.printf "%s\n" (string_of_prog task3_asm)
