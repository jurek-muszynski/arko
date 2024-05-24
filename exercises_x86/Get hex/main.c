#include <stdio.h>
#include "gethex.h"

int main(int argc, char *argv[])
{
    if (2 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    int n = gethex(argv[1]);
    printf("Text: %s Hex: %d\n", argv[1], n);
    return 0;
}