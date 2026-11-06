#include <avr/io.h>
#include "spi.h"

int main(void)
{
    spi_init();
    uint8_t data = 0xAA;
    while (1)
    {
        spi_write(data);
        data++;
    }
}