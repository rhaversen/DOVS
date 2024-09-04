/* main.c: C wrapper for our assembly program */
#include <stdio.h>
extern int example (); /*  the name of our function */

int main() {
    int result = example();
    return result;
}