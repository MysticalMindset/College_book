/*
Lab Activity 2 – Control LEDs
Green LED (PF3) stays ON constantly.
Red LED (PF1) toggles:
    1 second ON
    2 seconds OFF
*/

#include "TM4C123GH6PM.h"

void delayMs(int n);

int Activity2(void)
{
    // Enable clock to GPIOF
    SYSCTL->RCGCGPIO |= 0x20;
    while((SYSCTL->PRGPIO & 0x20) == 0) {};   // wait for GPIOF ready

    // Set PF1 (red) and PF3 (green) as output
    GPIOF->DIR |= 0x0A;     // 00001010 (PF3 & PF1)

    // Enable digital function for PF1 and PF3
    GPIOF->DEN |= 0x0A;

    // Turn Green LED ON initially
    GPIOF->DATA |= 0x08;    // PF3 = 1

    while(1)
    {
        // Turn Red ON (Green stays ON)
        GPIOF->DATA |= 0x02;    // PF1 = 1
        delayMs(1000);          // 1 second

        // Turn Red OFF (Green remains ON)
        GPIOF->DATA &= ~0x02;   // PF1 = 0
        delayMs(2000);          // 2 seconds
    }
}

// Delay function (16 MHz clock)
void delayMs(int n)
{
    int i, j;
    for(i = 0; i < n; i++)
        for(j = 0; j < 3180; j++)
        {}   // 1 ms delay
}