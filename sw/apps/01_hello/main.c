
#include "main.h"
// #include "dledbar.h"
#include "dtty.h"
#include <stdint.h>

int main(void)
{
    while (1)
    {
        TTY_CHAR = '>';
        tty_write("Hello\n");
    };
}
