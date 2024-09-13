#include <stdio.h>
#include <inttypes.h>

// Function to read an integer from the console
int64_t read_integer() {
    int64_t value;
    printf("Please enter an integer: ");
    scanf("%" PRId64, &value);
    return value;
}

extern long eprog_01();
extern long eprog_02();
extern long eprog_03();

// Function to print an integer (used by the assembly code)
void print_int(int x) {
    printf("%d\n", x);
}

int main() {
    // Call each assembly function
    eprog_01();
    eprog_02();
    eprog_03();

    return 0;
}
