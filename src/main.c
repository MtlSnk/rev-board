#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB = 0b00011111;
    DDRC = 0b00000001;
    DDRD = 0b11111100;
    
    while (1) {
        PORTB ^= 0b00011111;
        PORTC ^= 0b00000001;
        PORTD ^= 0b11111100;
        _delay_ms(1000);
    }
}
