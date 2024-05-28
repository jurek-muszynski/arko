#include <stdio.h>
#include "removedigits.h"

int main(int argc, char *argv[])
{
    if (3 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    printf("Inital text: %s\n", argv[1]);
    printf("Text to delete numbers from: %s\n", argv[2]);
    removedigits(argv[1], argv[2]);
    printf("Transformed text: %s\n", argv[1]);
    return 0;
}