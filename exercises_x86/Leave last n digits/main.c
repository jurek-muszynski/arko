#include <stdio.h>
#include "leavelastndigt.h"

int main(int argc, char *argv[])
{
    if (3 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    leavelastndigt(argv[1], (int)*argv[2] - 48);
    printf("%s\n", argv[1]);
    return 0;
}