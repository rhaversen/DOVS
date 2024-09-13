# Assignment 2

To compile the code, run 

```bash
make
```

To run the compiled code (which runs tests for task 1 and 2), run

```bash
./main.native
```

# Task 1: Pretty printer for expression programs

We are to write a function ```string_of_eprog``` that has type ```eprog -> string``` for pretty printing arithmetic expressions.

The solution is provided in ```pretty.ml```. It includes a test function which tests the provided examples from the task description.

It buiilds upon the ```string_of_expr``` function from the last assignment, which has itself been extended to include the new var construct. The function ```string_of_eprog``` pattern matches on the ```eprog``` type for return, val and input constructs, and then uses the ```string_of_expr``` function to pretty print the expression, concatenating the string of expressions with the appropriate delimiters and prefixes.

# Task 2: Semantic analysis

We are to write a function ```semant``` that has type ```eprog -> semant_result``` for checking type errors in programs.

The solution is provided in ```semanticAnalysis.ml```. It includes a test function which tests the provided examples from the task description.

The solution works by recursively processing the program's statements and expressions to perform semantic analysis. It maintains a list of declared variables to check for semantic errors. If the variable is already in the declared list. If so, it records a ```Duplicate``` error. In ```Val (v, e)```, it recursively processes the expression ```e``` to check for undeclared variables. When encountering a variable ```(Var v)```, it checks if ```v``` is in the declared list. If not, it records an ```Undeclared``` error. For binary operations, it recursively checks both subexpressions.

## Question 1:

Does ```semant``` need to be recursively inspect its argument? Why or why not? What auxiliary functions do you define? Are any of them recursive or not and why?

Yes, semant needs to recursively inspect its argument because the program is a tree structure, and the function needs to traverse the tree to perform the semantic analysis.

We have defined an auxiliary functions ```process_stmts``` and ```process_expr``` to process the list of statements process the expressions in the program, respectively. Both functions are recursive because they need to process the list of statements and expressions in the program. ```process_stmts``` is recursive to iterate through the list of statements, and ```process_expr``` is recursive to process the nested expressions such as binary operations with subexpressions.

## Question 2:

Describe how you keep track of variable declarations in your implementation. What data structure(s) do you use?

We keep track of variable declarations using a list of variable names ```(declared_vars)```. This list is updated as we recursively process the program's statements and expressions. The data structure used is a list of strings, where each string represents a declared variable name.
