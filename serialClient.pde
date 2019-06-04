//This example program connects to an Arduino over Serial connection. It automatically finds the correct Serial port.

import processing.serial.*;

Serial[] ports = new Serial[Serial.list().length];
Serial myArduinoPort;  
String received;    
boolean firstContactEstablished = false;

void setup() {
  // iterate over all serial ports to find correct one
  for(int i =0; i < Serial.list().length; i++) {
    try { ports[i] = new Serial(this, Serial.list()[i], 9600);
    ports[i].bufferUntil('\n'); }
    catch (Exception e) {
      //invalid port, ignore
    } 
  }
}

void draw() {
}

void serialEvent( Serial myPort) {
  received = myPort.readStringUntil('\n');
  if (received != null) {
    received = trim(received);
    println(received);
    
    if (firstContactEstablished == false) {
      if (received.equals("thisIsVenturi")) {
        myPort.clear();
        firstContactEstablished = true;
        // save the identified port
        myArduinoPort = myPort;
        myPort.write("helloVenturi");
      }
    }
    else {
      println(received);
      myPort.write("helloVenturi");
      }
    }
}
