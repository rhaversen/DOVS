# Assignment 3

## Task 1: Translating to favorite language

My favourite language is TypeScript, although for this simple task I will use JavaScript. The task is to translate the following code to my favourite language.

Im using C# syntax highlighting for the dolphin code as it most closely resembles the syntax highlighting given in the task description.

```C#
void number_perfect(n : int){
  var i = 1;
  while(i <= n){
    var temp = 0;
    for (var j = 1; j < i; j = j + 1){
      let d = i % j;
      temp = temp + (d == 0 ? j : 0);
    }
    if(temp == i)
      print_perfect(i);
    i = i + 1;
  }
}
```

The code above is a function that prints all perfect numbers up to n. A perfect number is a positive integer that is equal to the sum of its proper divisors, excluding itself. For example, 6 is a perfect number because 6 = 1 + 2 + 3.

Additional printer code in C:

```C
#include <stdio.h>         /* make sure these two includes are    */
#include <inttypes.h>      /* present in the start of your C file */

void print_perfect(int64_t i) {
  printf("%" PRId64 ": perfect\n", i);
}

int main() {
  number_perfect(10000);
  return 0;
}
```

Here is the code translated to JavaScript including the print function and comments for significant parts of the code:

```javascript
function numberPerfect(num) {
    let i = 1;
    
    while (i <= num) {
        let temp = 0;
        
        // Loop to find divisors of 'i'
        for (let j = 1; j < i; j++) {
            let d = i % j; // Check if 'j' is a divisor
            temp = temp + (d === 0 ? j : 0); // Add the found divisor to 'temp' if true
        }
        
        // Check if 'i' is a perfect number
        if (temp === i) {
            printPerfect(i); // Output perfect number
        }
        
        i++;
    }
}

function printPerfect(num) {
    console.log(`${num}: perfect`); // Output perfect number in format
}

numberPerfect(10000); // Find perfect numbers up to 10,000
```

The code can be run in an online playground like ```https://www.programiz.com/javascript/online-compiler/``` or in the browser console where the following output will be printed:

```
"6: perfect"
"28: perfect"
"496: perfect"
"8128: perfect"
```

This resembles the given output in the task description which validates that the code is working as expected.

## Task 2: Translating to ```LLVM--```

The task is to translate the same code to ```LLVM--```. The translated code is given in ```perfect.ll``` along with comments explaining the code.

To compile, link and run the code, the following commands can be used:

```bash
clang perfect.ll main.c
./a.out
```

The output will be the same as in the previous task:

```
6: perfect
28: perfect
496: perfect
8128: perfect
```

### Question 1

- How many basic block does your program have? Explain how you count basic blocks.

The program has 9 basic blocks. The blocks consist of the following:

1. entry
2. while_cond
3. while_body
4. for_cond
5. for_body
6. for_end
7. if_then
8. if_end
9. while_end

A basic block in LLVM IR is a sequence of instructions that has a single entry point and a single exit point with no branches out except at the end. A label followed by a colon (```%label:```) is used to define the beginning of a basic block. We simply count the labels.

### Question 2

- How do you handle division by zero? Do you produce code for checking that the divisor is non-zero? Why?

Division by zero is inherently prevented by the loop logic. Since ```j``` starts at 1 and is incremented by 1 in each iteration, the loop will never reach a point where ```j``` is zero. Furthermore, the condition ```j < i``` ensures that ```j``` is always in a valid range. Finally, the division operation ```%d = srem i32 %i_val_3, %j_val_2``` (```i % j```) in the ```for_body``` block is always safe, because ```j_val_2``` is never zero.

### Task 3: Debug ```LLVM--```

We are given the following Dolphin program:

```C#
int rec_fun(acc : int, n : int){
  if(n > 0)
    return rec_fun(acc + 2, n - 1);
  return acc;
}
```

It is translated to ```LLVM--``` with a buggy compiler and produces the following code:

```llvm
define i64 @rec_fun (i64 %acc, i64 %n) {
 %n6 = alloca i64
 %acc5 = alloca i64
 store i64 %acc, i64* %acc5
 store i64 %n, i64* %n6
 %load_local_var7 = load i64, i64* %n6
 %arith_comp_op8 = icmp slt i64 %load_local_var7, 0 ; The identified bug is here
 br i1 %arith_comp_op8, label %ifthenelse_true_branch9, label %ifthenelse_false_branch10
ifthenelse_true_branch9:
 %load_local_var12 = load i64, i64* %acc5
 %arith_bin_op13 = add i64 %load_local_var12, 2
 %load_local_var14 = load i64, i64* %n6
 %arith_bin_op15 = sub i64 %load_local_var14, 1
 %call16 = call i64 @rec_fun (i64 %arith_bin_op13, i64 %arith_bin_op15)
 ret i64 %call16
after_return17:
 br label %ifthenelse_merge11
ifthenelse_false_branch10:
 br label %ifthenelse_merge11
ifthenelse_merge11:
 %load_local_var18 = load i64, i64* %acc5
 ret i64 %load_local_var18
after_return19:
 unreachable
}
```

We are to identify the issue in the translated code which leads to a crash with segmentation fault if the function is called with parameters ```rec_fun(0, -10)```.

In the Dolphin code, the base case is when ```n``` is less than or equal to zero, where it simply returns the acc. The recursive case is when ```n``` is greater than zero, where it calls itself with ```acc + 2``` and ```n - 1```.

Since the function is called with ```rec_fun(0, -10)```, the base case should be reached immediately and the function should return 0. However, the translated code does not handle the base case correctly. The issue is in the following lines:

```llvm
%arith_comp_op8 = icmp slt i64 %load_local_var7, 0
br i1 %arith_comp_op8, label %ifthenelse_true_branch9, label %ifthenelse_false_branch10
```

```icmp slt i64 %load_local_var7, 0``` compares if ```n``` is less than zero, which is incorrect. In the original Dolphin code, the condition is ```if(n > 0)```, so the correct comparison should be ```icmp sgt i64 %load_local_var7, 0```.

The issue leads to an infinite recursion because the base case is never reached, and thus the stack overflows and the program crashes with a segmentation fault.

### Question 5

- Make an educated guess as to what the compiler has done wrong to produce such a buggy code (this is about the bug in the compiler that leads to the bug in the code of Task 3).

One possibility is that compiler misinterprets the comparison operator. It incorrectly maps the ```>``` operator to ```<```. In this case, the fix could be as simple as fixing the mapping of a switch case in the compiler code.

### Question 6

- Find at least one other way a subtle mistake in the code generation phase of the compiler can cause a segmentation fault in a program like the one above.

Another possible compiler bug which leads to segnemtation fault could be misordering the operands instead of accidentally flipping the comparison operator. This would also lead to an infinite recursion and stack overflow.
