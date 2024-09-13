# Assignment 2

To compile the code, run 

```bash
make
```

To run the compiled code (which runs tests for task 1 and 2 and 3, and prints the assembly code for some example programgs for task 4), run

```bash
./main.native
```

The printed assembly code for task 4 (With corrected function names) is provided in ```asmTask.s```. To compile the assembly code, run

```bash
clang main.c asmTask.s
```

Then, to run the compiled assembly code (which prints the outputs of the expressions in ascending order), run

```bash
./a.out
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

# Task 3: Evaluation of expression programs

We are to write a function ```eval``` that has type ```eprog -> int``` for evaluating expression programs. We a given a a function ```eprog_input``` for evaluating the input statements:

```ocaml
let eprog_input() 
   = Printf.printf "Please enter an integer: " ; read_line () |> int_of_string
```

The solution is provided in ```eval.ml```. It includes a test function which tests the provided examples from the task description. It also includes functions with an input statement to test the input functionality. Check out the implementation for those programs to validate the result manually.

## Question 4:

In the given code, ```;``` is the OCaml sequencing and ```|>``` is the OCaml pipeline operator. How would you write the implementation of ```eprog_input``` using just the ```let``` expressions without these operators?

We can write the implementation of ```eprog_input``` using just the ```let``` expressions without the ```;``` and ```|>``` operators as follows:

```ocaml
let eprog_input () = 
  let () = Printf.printf "Please enter an integer: " in
  let input = read_line () in
  int_of_string input
```

The first ```let``` expression prints the prompt message, and the second ```let``` expression reads the input as a string. The third line converts the input string to an integer using the ```int_of_string``` function.

## Question 6:

What data structure(s) do you use in the implementation of the interpreter?

We use a list for the environment to store the variable bindings. The environment is a list of tuples ```(varname, value)``` where ```varname``` is the variable name and ```value``` is the integer value of the variable. The environment is updated as we evaluate the program's statements and expressions.

## Question 7:

What runtime errors are possible during the execution of your interpreter? Are they preventable, and how?

Yes, there are possible runtime errors during the execution of the interpreter. Some of the possible runtime errors are:

1. Division by zero: If the program contains a division operation with a divisor of zero, it will result in a division by zero error caused by the ```Div``` operation.

This can not be resolved by the interpreter, as it is a runtime error. The program should be modified to avoid division by zero.

2. Variable not found: If the program contains a variable that is not declared, it will result in a variable not found error caused by ```List.assoc``` function.

This can be resolved by performing semantic analysis before evaluating the program to check for undeclared variables.

3. Input Conversion Error: If the input provided by the user is not a valid integer, it will result in an input conversion error caused by the ```int_of_string``` function.

This can be resolved by validating the input before converting it to an integer, and prompt the user repeatedly until a valid integer is entered.

# Task 4: Compiling expression programl to x86

We are to write a function ```eprog_to_x86``` that has type ```eprog -> X86.prog``` for compiling expression programs to x86 assembly code.

The solution is provided in ```asmTask.ml```. It includes a test function which tests some example programs. The compiled assembly code is printed to the console, and also written to a file ```asmTask.s```.

At this point, i ran out of time to complete the rest of the assignment.
