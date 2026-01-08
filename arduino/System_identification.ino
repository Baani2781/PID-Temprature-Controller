const int heaterPin = 10;       // PWM pin connected to heater (via MOSFET)
const int tempPin = A0;        // Analog pin connected to LM35
unsigned long startTime;

void setup() {
  pinMode(heaterPin, OUTPUT);
  pinMode(tempPin, INPUT);
  Serial.begin(9600);
  delay(2000);  // Give some time before starting

  analogWrite(heaterPin, 127);  // 50% PWM duty cycle (127 out of 255)
  startTime = millis();         // Start timing
}

void loop() {
  int analogValue = analogRead(tempPin);
  float temperature = (analogValue * 5.0 / 1023.0) * 100.0;  // LM35: 10mV/°C

  unsigned long elapsedTime = millis() - startTime;
  Serial.print(elapsedTime / 1000.0);  // Time in seconds
  Serial.print(",");
  Serial.println(temperature);

  delay(500);  // Read every 0.5 seconds
}
