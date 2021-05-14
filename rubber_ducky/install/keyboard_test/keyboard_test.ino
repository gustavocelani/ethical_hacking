
#define LAYOUT_PORTUGUESE_BRAZILIAN
#include "DigiKeyboard.h"

#define LED_PIN 1
#define LED_DELAY 250

#define KEYBOARD_DELAY 500

void setup() {
    pinMode(LED_PIN, OUTPUT);
}

void loop() {

    DigiKeyboard.sendKeyStroke(0);
    DigiKeyboard.delay(KEYBOARD_DELAY);
    DigiKeyboard.sendKeyStroke(KEY_R, MOD_GUI_LEFT);
    DigiKeyboard.delay(KEYBOARD_DELAY);
    DigiKeyboard.print("notepad");
    DigiKeyboard.sendKeyStroke(KEY_ENTER);
    DigiKeyboard.delay(KEYBOARD_DELAY);
    DigiKeyboard.print("abcdefghijklmnopqrstuvwxyz1234567890'\\\"!@#$%¨&*()-_=+[]{};><.,/?*-+");

    // The output String MUST be EXACTLY:
    // abcdefghijklmnopqrstuvwxyz1234567890'\"!@#$%0&*()-_=+[]{};><.,/?*-+

    // Blink LED after run
    for (;;) {
        digitalWrite(LED_PIN, HIGH);
        delay(LED_DELAY);
        digitalWrite(LED_PIN, LOW);
        delay(LED_DELAY);
    }
}
