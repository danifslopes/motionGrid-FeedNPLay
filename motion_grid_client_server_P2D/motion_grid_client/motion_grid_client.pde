//Based on: https://processing.org/reference/libraries/net/Client_readString_.html

import processing.net.*; 
Client myClient; 
String inString;
byte interesting = 10;

void setup() { 
  size (800, 500, P2D); //BE SURE THIS IS THE SAME SIZE AS IN MOTION_GRID_SERVER
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port ("MOTION_GRID_SOCKET")
  myClient = new Client(this, "127.0.0.1", 5204);
} 

void draw() { 
  background(0);
  fill(255);
  stroke(255);

  if (myClient.available() > 0) { 
    inString = myClient.readString(); 
    if (inString.length()>0) {
      String[] activeCells = split(inString, "+");
      for (String s : activeCells) if (s.length() >0) {
        String[] values = split(s, ";");
        println(float(values[0]), float(values[1]), float(values[3]));
        
        //DO SOMETING:
        circle(float(values[0]), float(values[1]), float(values[2]));
        //circle(float(values[0]), float(values[1]), float(values[3]));
        
      }
    }
  }
} 
