#include <stdio.h>
#include "repllet.h"

int main(int argc, char *argv[])
{
    if (3 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    repllet(argv[1], *argv[2]);
    printf("%s\n", argv[1]);
    return 0;
}