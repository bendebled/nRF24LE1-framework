#include "wiring.h"
#include <stdio.h>

#define DEBUG 1
#define LED	P0_1
#define LED_ON	LOW
#define LED_OFF	HIGH

void setup()
{
	pinMode(LED, OUTPUT);
}

void loop()
{
	digitalWrite(LED, LED_ON);	
	delay(1000);
	digitalWrite(LED, LED_OFF);
	delay(1000);
}