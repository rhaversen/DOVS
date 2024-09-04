#include <stdio.h>

// Function declarations
extern long task3_exp1();
extern long task3_exp2();
extern long task3_exp3();
extern long task3_exp4();
extern long task3_exp5();

int main() {
    // Call each assembly function and print the results
    printf("Result of task3_exp1: %ld\n", task3_exp1());
    printf("Result of task3_exp2: %ld\n", task3_exp2());
    printf("Result of task3_exp3: %ld\n", task3_exp3());
    printf("Result of task3_exp4: %ld\n", task3_exp4());
    printf("Result of task3_exp5: %ld\n", task3_exp5());

    return 0;
}

void print_int (int x) {
    printf ("%d\n", x);
}