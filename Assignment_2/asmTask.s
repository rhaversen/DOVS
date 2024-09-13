        .text
        .globl  eprog_01
eprog_01:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $64, %rsp
        movq    $2, %rax
        pushq   %rax
        movq    $3, %rax
        popq    %rbx
        addq    %rbx, %rax
        movq    %rax, %rdi
        callq   print_int
        addq    $64, %rsp
        popq    %rbp
        retq
        .text
        .globl  eprog_02
eprog_02:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $64, %rsp
        movq    $2, %rax
        pushq   %rax
        movq    $1, %rax
        pushq   %rax
        movq    $2, %rax
        popq    %rbx
        addq    %rbx, %rax
        popq    %rbx
        imulq   %rbx, %rax
        movq    %rax, %rdi
        callq   print_int
        addq    $64, %rsp
        popq    %rbp
        retq
        .text
        .globl  eprog_03
eprog_03:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $64, %rsp
        movq    $10, %rax
        pushq   %rax
        movq    $2, %rax
        popq    %rbx
        addq    %rbx, %rax
        pushq   %rax
        movq    $4, %rax
        popq    %rbx
        subq    %rbx, %rax
        movq    %rax, %rdi
        callq   print_int
        addq    $64, %rsp
        popq    %rbp
        retq