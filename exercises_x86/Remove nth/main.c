#include <stdio.h>
#include "f.h"

int main(int argc, char *argv[])
{
    if (3 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }

    int n;
    sscanf(argv[2], "%d", &n);
    printf("Initial string: %s\n", argv[1]);
    if (!n)
    {
        printf("Invalid arg.\n");
        return -1;
    }
    printf("Remove every %d character\n", n);
    func(argv[1], n);
    printf("Result: %s\n", argv[1]);
    return 0;
}