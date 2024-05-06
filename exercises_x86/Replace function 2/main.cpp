#include <stdio.h>
#include <string.h>
extern "C" int replace(char *s);

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: %s <string>\n", argv[0]);
        return -1;
    }

    char *str = argv[1];
    int str_len = strlen(str);

    printf("Source: %s\n", str);
    int result = replace(str);
    printf("Result: %s\n", str);
    printf("Return value: %d\n", result);

    return 0;
}
