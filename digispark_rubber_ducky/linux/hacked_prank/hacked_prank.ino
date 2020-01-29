
/********************************************************************************
 *            ____  ____           ____        _     _
 *           / ___|/ ___|         |  _ \ _   _| |__ | |__   ___ _ __
 *          | |  _| |      _____  | |_) | | | | '_ \| '_ \ / _ \ '__|
 *          | |_| | |___  |_____| |  _ <| |_| | |_) | |_) |  __/ |
 *           \____|\____|         |_| \_\\__,_|_.__/|_.__/ \___|_|
 *        ____             _            ____            _       _
 *       |  _ \ _   _  ___| | ___   _  / ___|  ___ _ __(_)_ __ | |_ ___
 *       | | | | | | |/ __| |/ / | | | \___ \ / __| '__| | '_ \| __/ __|
 *       | |_| | |_| | (__|   <| |_| |  ___) | (__| |  | | |_) | |_\__ \
 *       |____/ \__,_|\___|_|\_\\__, | |____/ \___|_|  |_| .__/ \__|___/
 *                              |___/                    |_|
 *
 ********************************************************************************
 *              Copyright (C) Gustavo Celani - All Rights Reserved
 *            Written by Gustavo Celani <gustavo_celani@hotmail.com>
 *******************************************************************************/

/* Libraries */
#include "DigiKeyboard.h"

/* Definitions */
#define LED_PIN  1
#define DELAY    500

/* Open Linux Terminal */
void open_terminal() {
	DigiKeyboard.sendKeyStroke(KEY_T, MOD_CONTROL_LEFT|MOD_ALT_LEFT);
	DigiKeyboard.delay(DELAY);
}

/* Executes an command and press Enter Key */
void execute(char *command) {
	DigiKeyboard.print(command);
	DigiKeyboard.sendKeyStroke(KEY_ENTER);
	DigiKeyboard.delay(DELAY);
}

/* Press a Key */
void press_key(int key) {
	DigiKeyboard.sendKeyStroke(key);
	DigiKeyboard.delay(DELAY);
}

/* Finishes Process */
void finish() {

	// Turn LED ON
	digitalWrite(LED_PIN, HIGH);

	// Infinity Loop
	for (;;) {  }
}

/* Setup */
void setup() {
	// LED Setup
	pinMode(LED_PIN, OUTPUT);
	digitalWrite(LED_PIN, LOW);

	// Initializing
	DigiKeyboard.sendKeyStroke(0);
	DigiKeyboard.delay(DELAY);
}

/* Loop */
void loop() {

	open_terminal();

	execute("firefox");
	execute("fakeupdate.net/wnc/");
	press_key(KEY_F11);

	finish();
}

