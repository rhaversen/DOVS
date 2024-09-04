# Assignment 1

To compile the code, run 

```bash
make
```

To run the compiled code (which runs tests for task 1 and 2, prints the translated assembly code for task 1 and 2 and prints the evaluations for task 3), run

```bash
./main.native
```

The printed assembly code for task 3 is provided in ```asmTask.s```. To compile the assembly code, run

```bash
clang main.c asmTask.s
```

Then, to run the compiled assembly code (which prints the outputs of the expressions in ascending order), run

```bash
./a.out
```

# Task 1: Evaluator for arithmetic expressions

We are to write a function ```eval``` that has type ```expr -> int``` for evaluating arithmetic expressions.

The solution is provided in ```eval.ml```. It includes a test function which tests the provided examples from the task description. It also includes a function ```eval_asm``` which is used for task 3.

The solution works by recursively evaluating the expression. The function pattern matches on the expression to determine the type of the expression. If the expression is a constant, the function simply returns the constant, and if the expression is a binop, it matches with the operator and evaluates the left and right subexpressions recursively. The function then applies the operator to the results of the left and right subexpressions and returns the result.

The tests are implemented with a function ```test_case``` which takes an expression and the expected result as arguments. The function then calls ```string_of_expr``` with each expression and compares the result with the expected result. If the result matches the expected result, the test passes, otherwise the test fails. The test result is printed.

## Question 1:
Does this function need to recursively explore its argument, and why (or why not)?

Yes, this function needs to be recursive. This is because the expression is a tree structure, and the function needs to traverse the tree to evaluate the expression. The function needs to recursively evaluate the left and right subexpressions of the expression, and then combine the results according to the operator. This is done by calling the eval function on the left and right subexpressions, and then applying the operator to the results recursively until the base case is reached, which is when the expression is a constant, in which case the function simply returns the constant.

## Question 2:
Why does this function have the return type int? What other return types may be suitable?

The function has the return type ```int``` because the expression is an arithmetic expression, and the result of evaluating an arithmetic expression is an integer. Other return types that may be suitable are ```float``` and ```bool```, depending on the type of the expression. 

## Question 3:
How does your evaluation handle the case of division by zero? Note that it may be just fine to not special-treat division by zero, but it is important you understand what actually happens at runtime.

The evaluation does not handle the case of division by zero. If the expression contains a division by zero, the program will raise a Division_by_zero exception at runtime. The program will terminate with an uncaught exception.

# Task 2: Pretty printer for arithmetic expressions

We are to write a function ```string_of_expr``` that has type ```expr -> string``` for pretty printing arithmetic expressions.

The solution is provided in ```pretty.ml```. It includes a test function which tests the provided examples from the task description.

The solution works by recursively traversing the expression tree and building a string representation of the expression. The function pattern matches on the expression to determine the type of the expression, in similar fashion to the eval function. If the expression is a constant, the function simply returns the constant as a string. If the expression is a binop, the function recursively calls itself on the left and right subexpressions and then combines the results with the operator. The function then returns the combined string.

The test works similarly to the test in the eval function. It uses a function ```test_case``` which takes an expression and the expected result as arguments. The function then calls the ```string_of_expr``` function on the expression and compares the result with the expected result. If the result matches the expected result, the test passes, otherwise the test fails. The test result is printed.

## Question 4:
Are the functions you have defined recursive, and why (or why not)?

The function ```string_of_expr``` is recursive for the same reason as the evaluator. Handling it a tree structure is simpler, as you can match on the different cases of the expression and then recursively call the function on the subexpressions. This is done until the base case is reached, which is when the expression is a constant, in which case the function simply returns the constant as a string.

## Question 6:
What is the OCaml type of asm_example?

The OCaml type of ```asm_example``` is ```prog```, which is defined as ```elem list```. The type of ```elem``` is defined as a tuple of label of type ```string```, a global ```flag``` of type ```bool```, and an asm instruction. Therefore, it is a list of tuples that contain assembly instructions or labeled data. 

## Question 7:
How would you rewrite this to use the Asm module without the local module open directive?

To rewrite this to use the Asm module without the local module open directive, we would need to reference the Asm module explicitly by prefixing the functions and types from the Asm module with Asm. For example, we would write Asm.text instead of text, and Asm.gtext instead of gtext. This is because the functions and types from the Asm module are not in scope, so we need to explicitly reference them by prefixing them with Asm.

## Question 8:
Could we have used ```text``` instead of ```gtext```? Why?

Since ```gtext``` marks the label as global, it can be accessed from other modules. If we used ```text``` instead of ```gtext```, the label would not be global, and it would not be accessible from other modules, and the label would therefore not be global which is not the intended behavior.

## Question 9:
What output do you get from ```echo $?``` when returning the value 2023?

We get the integer 231. This is because the return value overflows and wraps around to fit into a single byte. This is because the return value is an unsigned 8-bit integer, and it can therefore only hold values from 0 to 255. If the return value is greater than 255, it will overflow and wrap around to fit into a single byte.

# Task 3: Translate OCaml expressions to assembly

Consider the following OCaml expressions:

```ocaml
let task3_exp1 = BinOp (Add, Int 20, BinOp (Mul, Int 26, Int 58))
let task3_exp2 = BinOp (Mul, Int 5, BinOp (Div, Int 1, Int 10))
let task3_exp3 = BinOp (Sub, Int 31, Int 870)
let task3_exp4 = BinOp (Mul, BinOp (Add, BinOp (Div, Int 6, BinOp (Add, Int 10, Int 49)), Int 10), BinOp (Add, BinOp (Sub, BinOp (Mul, Int 70, Int 77), BinOp (Div, Int 12, Int 9)), Int 5))
let task3_exp5 = BinOp (Sub, BinOp (Div, Int 34, Int 72), BinOp (Div, Int 17, Int 46))
```

We are to translate these OCaml expressions to assembly instructions manually. Afterwards, we will cross reference the outputs of the assembly programs with our evaluation function to verify that the assembly programs are correct.

The solution is provided in ```asm.ml``` and the subsequently printed code is provided in ```asmTask.s```. It includes a ```print_asm``` function which prints the assembly instructions for the OCaml expressions. Documentation for the code is included in ```asm.ml```.

The results of the assembly code are as follows:

```
1528
0
-839
52767
0
```

We will now cross reference the outputs of the assembly programs with our evaluation function to verify that the assembly programs are correct. The results of the evaluation function are as follows:

```
Expression 1: 1528
Expression 2: 0
Expression 3: -839
Expression 4: 53940
Expression 5: 0
```

We can that the results of the assembly programs almost match the results of the evaluation function. The only difference is in the result of expression 4, which is 53940 in the evaluation function and 52767 in the assembly program. Wolfram alpha calculates the expression to 54485.175, which means both the evaluator and the assembly program are incorrect. The assembly program is incorrect because it uses 8-bit registers, which causes overflow. The evaluator is incorrect because it uses integer division, which causes truncation.