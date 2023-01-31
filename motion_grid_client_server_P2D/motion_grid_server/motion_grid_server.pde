//BY DANIE'LOPES
//BASED ON: https://processing.org/reference/libraries/net/Server.html

import processing.video.*;
import processing.net.*;

Server myServer;
int val = 0;
MotionGrid mg;

void setup() {
  size(800, 500); //BE SURE THIS IS THE SAME SIZE AS IN MOTION_GRID_CLIENT
  myServer = new Server(this, 5204); 
  
  mg = new MotionGrid(this, 30, 10, 5); //num celulas x. num celulas y 5 de sensibilidade
  mg.mode(CENTER);
  mg.transform(width/2, height/2, width, height); //0
  mg.setForces(5, 2, 1); //maxForce, forceInc, forceIncNeg
}

void draw() {
  ArrayList<float[]> activeCells = mg.getActiveCells();
  String msg = "";
  for (int i=0;i<activeCells.size();i++){
    msg += activeCells.get(i)[0] + ";" + activeCells.get(i)[1] + ";" + activeCells.get(i)[2] + ";" + activeCells.get(i)[3] + "+";
  }
 
  myServer.write(msg);
  
  mg.draw(); //JUST FOR DEBUG. COMMENT THIS.
}
