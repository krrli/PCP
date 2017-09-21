#include <stdio.h>

int main() {
    printf("Hello, World!\n");

    printNumbersGoto(7);
    printf("= printNumbersGoto(7)");
    printf("\n");

    printNumbersFor(7);
    printf("= printNumbersFor(7)");
    printf("\n");

    printNumbersRecursiveFunction(7);
    printf("= printNumbersRecursiveFunction(7)\n");
    printf("\n");

    return 0;
}

void printNumbersGoto(int n){
    int counter = 0;
    start:
    printf(" %i ", counter++);
    if(counter != n+1) goto start;
}

void printNumbersFor(int n){
    for(int i = 0; i <= n; i++){
        printf(" %i ", i);
    }
}

void printNumbersRecursiveFunction(int n){

    if(n > 0){
        printNumbersRecursiveFunction(n-1);
    }

    printf(" %i ", n);
}