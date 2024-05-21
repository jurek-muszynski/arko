#include <stdio.h>
#include "f.h"

int main(int argc, char *argv[])
{
    if (4 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    func(argv[1], *argv[2], *argv[3]);
    printf("%s\n", argv[1]);
    return 0;
}