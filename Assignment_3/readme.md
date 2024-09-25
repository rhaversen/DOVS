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
