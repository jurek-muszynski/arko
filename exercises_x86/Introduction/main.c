#include <stdio.h>

void func(char *);

int main(int argc, char *argv[])
{
    if (2 > argc)
    {
        printf("Arg missing.\n");
        return -1;
    }
    func(argv[1]);
    printf("%s\n", argv[1]);
    return 0;
}