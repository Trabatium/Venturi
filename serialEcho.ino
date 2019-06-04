/**
 * This program sends a string over the Serial port until a connection is established.
 * From then on, it echoes back every string it receives on the Serial input.
 * Credits: https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing/all
 */

String received;

void setup() {
  Serial.begin(9600);
  establishContact(); 

}

void loop() {
  if (Serial.available() > 0) { 
    received = Serial.readString();
    Serial.println(received); //echo string back
    delay(50);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
  Serial.println("thisIsVenturi");   // send a capital A
  delay(300);
  }
}
