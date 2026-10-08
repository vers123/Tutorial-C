#include "greet.h"
#include <stdio.h>

int main(void) {
    printf("%s\n", greet_message());
    printf("1 + 2 = %d\n", add(1, 2));
    return 0;
}
