#include <stdio.h>
#include "replnum.h"

int main(int argc, char *argv[])
{
    if (2 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    replnum(argv[1], *argv[2]);
    printf("%s\n", argv[1]);
    return 0;
}