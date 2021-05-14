
#define LED_PIN 1
#define LED_DELAY 250

void setup() {
    pinMode(LED_PIN, OUTPUT);
}

void loop() {
    digitalWrite(LED_PIN, HIGH);
    delay(LED_DELAY);
    digitalWrite(LED_PIN, LOW);
    delay(LED_DELAY);
}
