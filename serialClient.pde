//This example program connects to an Arduino over Serial connection. It automatically finds the correct Serial port.

import processing.serial.*;
import controlP5.*;

Serial[] ports = new Serial[Serial.list().length];
Serial myArduinoPort;  
String received;    
boolean firstContactEstablished = false;

ControlP5 cp5;
Textlabel label;

void setup() {
  // iterate over all serial ports to find correct one
  for(int i =0; i < Serial.list().length; i++) {
    try { ports[i] = new Serial(this, Serial.list()[i], 9600);
    ports[i].bufferUntil('\n'); }
    catch (Exception e) {
      //invalid port, ignore
    } 
  }
  
  // initialize GUI
  size(500,500);
  cp5 = new ControlP5(this);
  
  cp5.addButton("exampleButton1")
    .setPosition(10, 50)
    .setSize(120, 100);
    
  cp5.addButton("exampleButton2")
    .setPosition(10, 250)
    .setSize(120, 100);
    
  label = cp5.addTextlabel("exampleLabel")
    .setPosition(150, 50)
    .setSize(120, 100)
    .setFont(createFont("Georgia",20));
    
  label.setStringValue("waiting for Arduino...");
}

void draw() {
  background(150, 0 , 150);
}

void serialEvent( Serial myPort) {
  received = myPort.readStringUntil('\n');
  if (received != null) {
    received = trim(received);
    
    if (firstContactEstablished == false) {
      if (received.equals("thisIsVenturi")) {
        myPort.clear();
        firstContactEstablished = true;
        // save the identified port
        myArduinoPort = myPort;
        myPort.write("connected");
      }
    }
    else {
      println(received);
      label.setStringValue(received);
      }
    }
}

void exampleButton1(){
  myArduinoPort.clear();
  myArduinoPort.write("button 1 clicked");
}

void exampleButton2(){
  myArduinoPort.clear();
  myArduinoPort.write("button 2 clicked");
}
