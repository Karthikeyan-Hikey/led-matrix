#include "spi.h"
#include <avr/io.h>

void spi_init(void){
    SPCR = 0U;
    // Setting the DDRB register to set MOSI, SCK, and CS as output pins
    DDRB |= (1 << DDB3)|(1 << DDB5)|(1 << DDB2);
    // Setting the SPI control register SPCR
    SPCR |= (1 << SPE) | (1 << MSTR) | (1 << SPR0);
}