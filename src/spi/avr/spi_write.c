#include "spi.h"
#include <avr/io.h>

void spi_write(uint8_t data)
{
    // Start transmission
    SPDR = data;

    // Wait until the byte has been transmitted
    while (!(SPSR & (1 << SPIF)))
    {
    }
}