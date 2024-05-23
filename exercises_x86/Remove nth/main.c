#include <stdio.h>
#include "f.h"

int main(int argc, char *argv[])
{
    if (3 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    func(argv[1], 2);
    printf("%s\n", argv[1]);
    return 0;
}