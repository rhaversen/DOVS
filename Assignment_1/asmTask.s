        .text
        .globl  task3_exp1
task3_exp1:
        movq    $26, %rax
        imulq   $58, %rax
        addq    $20, %rax
        retq
        .text
        .globl  task3_exp2
task3_exp2:
        movq    $1, %rax
        movq    $10, %rbx
        cqto
        idivq   %rbx
        imulq   $5, %rax
        retq
        .text
        .globl  task3_exp3
task3_exp3:
        movq    $31, %rax
        subq    $870, %rax
        retq
        .text
        .globl  task3_exp4
task3_exp4:
        movq    $10, %rax
        addq    $49, %rax
        movq    $6, %rbx
        cqto
        idivq   %rax
        addq    $10, %rax
        pushq   %rax
        movq    $70, %rax
        imulq   $77, %rax
        movq    $12, %rbx
        movq    $9, %rcx
        cqto
        idivq   %rcx
        subq    %rax, %rbx
        addq    $5, %rbx
        popq    %rax
        imulq   %rbx, %rax
        retq
        .text
        .globl  task3_exp5
task3_exp5:
        movq    $34, %rax
        movq    $72, %rbx
        cqto
        idivq   %rbx
        pushq   %rax
        movq    $17, %rax
        movq    $46, %rbx
        cqto
        idivq   %rbx
        popq    %rbx
        subq    %rax, %rbx
        retq