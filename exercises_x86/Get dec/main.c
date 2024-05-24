#include <stdio.h>
#include "getdec.h"

int main(int argc, char *argv[])
{
    if (2 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    int n = getdec(argv[1]);
    printf("Text: %s Int: %d\n", argv[1], n);
    return 0;
}