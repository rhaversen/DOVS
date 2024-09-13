# Assignment 2

To compile the code, run 

```bash
make
```

To run the compiled code (which runs tests for task 1), run

```bash
./main.native
```

# Task 1: Pretty printer for expression programs

We are to write a function ```string_of_eprog``` that has type ```eprog -> string``` for pretty printing arithmetic expressions.

The solution is provided in ```pretty.ml```. It includes a test function which tests the provided examples from the task description.

It buiilds upon the ```string_of_expr``` function from the last assignment, which has itself been extended to include the new var construct. The function ```string_of_eprog``` pattern matches on the ```eprog``` type for return, val and input constructs, and then uses the ```string_of_expr``` function to pretty print the expression, concatenating the string of expressions with the appropriate delimiters and prefixes.