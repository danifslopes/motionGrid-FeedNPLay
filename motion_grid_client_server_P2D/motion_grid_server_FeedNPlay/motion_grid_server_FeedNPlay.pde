//BY DANIE'LOPES
//BASED ON: https://processing.org/reference/libraries/net/Server.html

import processing.video.*;
import processing.net.*;

Server myServer;
int val = 0;
MotionGrid mg;

void settings() {
  size(800,500); //USE SIZE() FOR TESTING ON YOUR PC
  //fnpSize(9720, 1920); //FeedNplay screen size. Do not change! (by Tiago Martins)
}

void setup() {
  myServer = new Server(this, 5204); 
    
  mg = new MotionGrid( this, 30 /*NUM_CELLS_HORIZ*/, 15 /*NUM_CELLS_HORIZ*/, 5 /*HOW_MANY_PIXELS_NEED_TO_CHANGE_TO_ACTIVATE_CELL(sensibility)*/);
  mg.mode(CENTER); //Already setup for FeedNplay screen size. Do not change!
  mg.transform(width/2, height/2+(height/15), width, height*1.5); //Already setup for FeedNplay screen size. Do not change!
  //the longer a person is moving in front of a cell, the more the force grows (+FORCE_INC). Once moving stops, the force will decrease (-FORCE_DESC):
  mg.setForces(100 /*MAX_FORCE*/, 8 /*FORCE_INC*/, 2 /*FORCE_DESC*/); 

  fnpEndSetup(); //FeedNplay screen size. Do not change! (by Tiago Martins)
}

void draw() {
  ArrayList<float[]> activeCells = mg.getActiveCells();
  String msg = "";
  for (int i=0;i<activeCells.size();i++){
    msg += activeCells.get(i)[0] + ";" + activeCells.get(i)[1] + ";" + activeCells.get(i)[2] + ";" + activeCells.get(i)[3] + "+";
  }
 
  myServer.write(msg);
  
  //mg.draw(); //JUST FOR DEBUG. COMMENT THIS.
}
