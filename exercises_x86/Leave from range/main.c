#include <stdio.h>
#include "leaverng.h"

int main(int argc, char *argv[])
{
    if (4 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    printf("Initial text: %s\n", argv[1]);
    leaverng(argv[1], *argv[2], *argv[3]);
    printf("Transformed text: %s\n", argv[1]);
    return 0;
}