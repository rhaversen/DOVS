#include <stdio.h>
#include <inttypes.h>

void number_perfect(int32_t n); // I have added this line to declare the function

void print_perfect(int64_t i)
{
    printf("%" PRId64 ": perfect\n", i);
}

int main()
{
    number_perfect(10000);
    return 0;
}
