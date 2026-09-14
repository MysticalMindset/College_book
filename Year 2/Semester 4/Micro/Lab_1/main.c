/* 
Lab 2, Activity 1
This program blinks the red LED on the TI Tiva LaunchPad.
The connections are:
PF1 - red LED
PF2 - blue LED
PF3 - green LED
They are high active (a '1' turns on the LED).


#include "TM4C123GH6PM.h"

int main(void) {

    void delayMs(int n);

    // enable clock to GPIOF at clock gating control register
    SYSCTL->RCGCGPIO |= 0x20;

    // enable the GPIO pins for the LED (PF3, 2 1) as output
    GPIOF->DIR = 0x0e;

    // enable the GPIO pins for digital function
    GPIOF->DEN = 0x0e;

    while(1){
    GPIOF->DATA = 0x02;
    // turn on red LED
    delayMs(500);
    GPIOF->DATA = 0;
    // turn off red LED
    delayMs(500);
    }
}

// delay n milliseconds (16 MHz CPU clock)
void delayMs(int n){
    int i, j;
    for(i = 0 ; i < n; i++)
        for(j = 0; j < 3180; j++)
    {} // do nothing for 1 ms
}
*/

/*
Lab 2, Activity 2 – Control LEDs
Green LED (PF3) stays ON constantly.
Red LED (PF1) toggles:
    1 second ON
    2 seconds OFF


#include "TM4C123GH6PM.h"

void delayMs(int n);

int main(void){
    // Enable clock to GPIOF
    SYSCTL->RCGCGPIO |= 0x20;
    while((SYSCTL->PRGPIO & 0x20) == 0) {};   // wait for GPIOF ready

    // Set PF1 (red) and PF3 (green) as output
    GPIOF->DIR |= 0x0A;     // 00001010 (PF3 & PF1)

    // Enable digital function for PF1 and PF3
    GPIOF->DEN |= 0x0A;

    // Turn Green LED ON initially
    GPIOF->DATA |= 0x08;    // PF3 = 1

    while(1){
        // Turn Red ON (Green stays ON)
        GPIOF->DATA |= 0x02;    // PF1 = 1
        delayMs(1000);          // 1 second

        // Turn Red OFF (Green remains ON)
        GPIOF->DATA &= ~0x02;   // PF1 = 0
        delayMs(2000);          // 2 seconds
    }
}

// Delay function (16 MHz clock)
void delayMs(int n){
    int i, j;
    for(i = 0; i < n; i++)
        for(j = 0; j < 3180; j++)
        {}   // 1 ms delay
}
*/

/*
Lab 2, Activity 3 – Seven Segments

#include <stdint.h>
#include "TM4C123GH6PM.h"

void delayMs(int n);

int main(void)
{
    int digit;

    // 1. Enable clock for Port B
    SYSCTL->RCGCGPIO |= (1U << 1);
    while ((SYSCTL->PRGPIO & (1U << 1)) == 0);

    // 2. Configure PB0–PB3 as output
    GPIOB->DIR |= 0x0F;
    GPIOB->DEN |= 0x0F;
    GPIOB->AFSEL &= ~0x0F;
    GPIOB->AMSEL &= ~0x0F;

    while(1)
    {
        for(digit = 0; digit <= 9; digit++)
        {
            GPIOB->DATA = (GPIOB->DATA & ~0x0F) | digit;
            delayMs(1000); //1 sec
        }
    }
}

// Delay function (16 MHz clock)
void delayMs(int n){
    int i, j;
    for(i = 0; i < n; i++)
        for(j = 0; j < 3180; j++)
        {}   // 1 ms delay
}
*/

/*
Lab 2 [Part 2], Activity 1 – Control LED (CMSIS Version)


#include <stdint.h>
#include "TM4C123GH6PM.h"

void PortF_Init(void);
void Delay_ms(uint32_t n);
void Set_LED(uint8_t sw1, uint8_t sw2);

int main(void)
{
    uint8_t sw1, sw2;

    PortF_Init();

    while(1)
    {
        sw1 = (GPIOF->DATA & 0x10) >> 4;  // PF4
        sw2 = (GPIOF->DATA & 0x01);       // PF0

        Delay_ms(150);   // debounce

        if(((GPIOF->DATA & 0x10)>>4) == sw1 &&
           (GPIOF->DATA & 0x01) == sw2)
        {
            Set_LED(sw1, sw2);
        }
    }
}

void PortF_Init(void)
{
    SYSCTL->RCGCGPIO |= 0x20;          // Enable clock Port F
    while((SYSCTL->PRGPIO & 0x20)==0); // Wait ready

    GPIOF->LOCK = 0x4C4F434B;          // Unlock PF0
    GPIOF->CR |= 0x1F;

    GPIOF->DIR |= 0x0E;                // PF1,2,3 output
    GPIOF->DIR &= ~0x11;               // PF4,0 input

    GPIOF->PUR |= 0x11;                // Pull-up PF4 & PF0
    GPIOF->DEN |= 0x1F;                // Digital enable
}

void Delay_ms(uint32_t n)
{
    uint32_t i,j;
    for(i=0;i<n;i++)
        for(j=0;j<3180;j++);
}

void Set_LED(uint8_t sw1, uint8_t sw2)
{
    uint8_t led = 0;

    sw1 = !sw1;   // active LOW
    sw2 = !sw2;

    if(sw1==0 && sw2==0)
        led = 0x0E;    // White
    else if(sw1==1 && sw2==1)
        led = 0x02;    // Red
    else if(sw1==0 && sw2==1)
        led = 0x08;    // Green
    else if(sw1==1 && sw2==0)
        led = 0x04;    // Blue

    GPIOF->DATA = (GPIOF->DATA & 0x11) | led;
}
*/


/*
Lab 2 [Part 2], Activity 2 – Up/Down Counter


#include "TM4C123GH6PM.h"
#include <stdint.h>

void PortF_Init(void);
void PortB_Init(void);
void Delay_ms(int n);
void Display_Number(uint8_t num);
void Set_Up(uint8_t *counter);
void Set_Down(uint8_t *counter);

int main(void){
    uint8_t counter = 0;

    PortF_Init();
    PortB_Init();
    Display_Number(counter); // Show initial 0

    while(1)
    {
        // Call Set_Up() if SW1 pressed (PF4)
        Set_Up(&counter);

        // Call Set_Down() if SW2 pressed (PF0)
        Set_Down(&counter);
    }
}

// Increment function with debouncing
void Set_Up(uint8_t *counter)
{
    if((GPIOF->DATA & (1U<<4)) == 0) // SW1 pressed
    {
        Delay_ms(20); // debounce
        if((GPIOF->DATA & (1U<<4)) == 0) // confirm still pressed
        {
            *counter = (*counter + 1) % 10; // increment and wrap 0-9
            Display_Number(*counter);

            // Wait until release
            while((GPIOF->DATA & (1U<<4)) == 0);
            Delay_ms(20); // debounce after release
        }
    }
}

// Decrement function with debouncing
void Set_Down(uint8_t *counter)
{
    if((GPIOF->DATA & 1U) == 0) // SW2 pressed
    {
        Delay_ms(20); // debounce
        if((GPIOF->DATA & 1U) == 0) // confirm still pressed
        {
            if(*counter == 0)
                *counter = 9;
            else
                (*counter)--;
            Display_Number(*counter);

            // Wait until release
            while((GPIOF->DATA & 1U) == 0);
            Delay_ms(20); // debounce after release
        }
    }
}

void PortB_Init(void){
    SYSCTL->RCGCGPIO |= (1U << 1);        // Enable clock for PortB
    while((SYSCTL->PRGPIO & (1U << 1)) == 0);

    GPIOB->DIR |= 0x0F;      // PB0-3 output
    GPIOB->DEN |= 0x0F;      // digital enable
}

void PortF_Init(void){
    SYSCTL->RCGCGPIO |= (1U << 5);        // Enable clock for PortF
    while((SYSCTL->PRGPIO & (1U << 5)) == 0);

    // Unlock PF0 (required for TM4C123 LaunchPad)
    GPIOF->LOCK = 0x4C4F434B;             // Unlock GPIOCR register
    GPIOF->CR |= 1U;                       // Allow changes to PF0

    GPIOF->DIR &= ~((1U<<4) | 1U);       // PF4, PF0 input
    GPIOF->DEN |= (1U<<4) | 1U;          // digital enable
    GPIOF->PUR |= (1U<<4) | 1U;          // pull-up resistors
}

void Display_Number(uint8_t num){
    GPIOB->DATA = (GPIOB->DATA & 0xF0) | (num & 0x0F);
}

void Delay_ms(int n){
    int i, j;
    for(i=0; i<n; i++)
        for(j=0; j<3180; j++); // approx 1 ms delay at 16 MHz
}
*/