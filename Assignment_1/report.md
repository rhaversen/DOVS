# Task 1: Evaluator for arithmetic expressions

We are to write a function eval that has type expr -> int for evaluating arithmetic expressions.

The solution is provided in eval.ml. It includes a test function which tests the provided examples from the task description.

## Question 1:
Does this function need to recursively explore its argument, and why (or why not)?

Yes, this function needs to be recursive. This is because the expression is a tree structure, and the function needs to traverse the tree to evaluate the expression. The function needs to recursively evaluate the left and right subexpressions of the expression, and then combine the results according to the operator. This is done by calling the eval function on the left and right subexpressions, and then applying the operator to the results. This is done recursively until the base case is reached, which is when the expression is a constant, in which case the function simply returns the constant.

## Question 2:
Why does this function have the return type int? What other return types may be suitable?

The function has the return type int because the expression is an arithmetic expression, and the result of evaluating an arithmetic expression is an integer. The function evaluates the expression and returns the result as an integer. Other return types that may be suitable are float and bool, depending on the type of the expression. 

## Question 3:
How does your evaluation handle the case of division by zero? Note that it may be just fine to not special-treat division by zero, but it is important you understand what actually happens at runtime.

The evaluation does not handle the case of division by zero. If the expression contains a division by zero, the program will raise a Division_by_zero exception at runtime. The program will terminate with an uncaught exception.

# Task 2: Pretty printer for arithmetic expressions

We are to write a function string_of_expr that has type expr -> string for pretty printing arithmetic expressions.

The solution is provided in pretty.ml. It includes a test function which tests the provided examples from the task description.

## Question 4:
Are the functions you have defined recursive, and why (or why not)?

The function string_of_expr is recursive for the same reason as the evaluator. Handling it a tree structure is simpler, as you can match on the different cases of the expression and then recursively call the function on the subexpressions. This is done until the base case is reached, which is when the expression is a constant, in which case the function simply returns the constant as a string.

## Question 6:
What is the OCaml type of asm_example?

The OCaml type of asm_example is prog, which is defined as an elem list. The type of elem is defined as a tuple of label of type string, flag global of type bool, and an asm instruction. Therefore, it is a list of tuples that contain assembly instructions or labeled data. 

## Question 7:
How would you rewrite this to use the Asm module without the local module open directive?

To rewrite this to use the Asm module without the local module open directive, we would need to reference the Asm module explicitly by prefixing the functions and types from the Asm module with Asm. For example, we would write Asm.text instead of text, and Asm.gtext instead of gtext. This is because the functions and types from the Asm module are not in scope, so we need to explicitly reference them by prefixing them with Asm.

## Question 8:
Could we have used text instead of gtext? Why?

Since gtext marks the label as global, it can be accessed from other modules. If we used text instead of gtext, the label would not be global, and it would not be accessible from other modules. Therefore, if we used text instead of gtext, the label would not be global which is not the intended behavior in this case.

# Task 3: Translate the following 5 OCaml expressions to assembly
