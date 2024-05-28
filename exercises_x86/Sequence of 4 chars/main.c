#include <stdio.h>
#include "f.h"

int main(int argc, char *argv[])
{
    if (2 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    printf("Inital text: %s\n", argv[1]);
    func(argv[1]);
    printf("Transformed text: %s\n", argv[1]);
    return 0;
}