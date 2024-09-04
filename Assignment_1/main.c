#include <stdio.h>

// Function declarations
extern long task3_exp1();
extern long task3_exp2();
extern long task3_exp3();
extern long task3_exp4();
extern long task3_exp5();

int main() {
    // Call each assembly function
    task3_exp1();
    task3_exp2();
    task3_exp3();
    task3_exp4();
    task3_exp5();
    return 0;
}

void print_int (int x) {
    printf ("%d\n", x);
}