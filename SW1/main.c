#include <stdio.h>
#include "stack.h"

int main() {

    // Uebung 1

    printNumbersGoto(7);
    printf("= printNumbersGoto(7)\n");
    printNumbersFor(7);
    printf("= printNumbersFor(7)\n");
    printNumbersRecursiveFunction(7);
    printf("= printNumbersRecursiveFunction(7)\n\n");


    // Uebung 2
    stack myStack = init();

    print(myStack);
    top(myStack);
    myStack = push(42, myStack);
    myStack = push(77, myStack);
    myStack = push(1, myStack);
    print(myStack);
    myStack = push(33, myStack);
    myStack = pop(myStack);
    myStack = push(33, myStack);
    print(myStack);
    element e = top(myStack);
    printf("top element is %i\n", e);
    print(myStack);


    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);
    top(myStack);
    myStack = push(42, myStack);
    myStack = push(77, myStack);
    myStack = push(1, myStack);
    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);

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