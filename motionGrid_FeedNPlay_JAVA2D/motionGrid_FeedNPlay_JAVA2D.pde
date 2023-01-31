//BY DANI'LOPES
//YOU JUST NEED TO CHANGE THIS FILE
import processing.video.*;
MotionGrid mg;

void settings() {
  //size(800,600); //USE SIZE() FOR TESTING ON YOUR PC
  fnpSize(9720, 1920); //FeedNplay screen size. Do not change! (by Tiago Martins)
}

void setup() {
  mg = new MotionGrid( this, 50 /*NUM_CELLS_HORIZ*/, 30 /*NUM_CELLS_HORIZ*/, 5 /*HOW_MANY_PIXELS_NEED_TO_CHANGE_TO_ACTIVATE_CELL(sensibility)*/);
  mg.mode(CENTER); //Already setup for FeedNplay screen size. Do not change!
  mg.transform(width/2, height/2+(height/15), width, height*1.5); //Already setup for FeedNplay screen size. Do not change!
  //the longer a person is moving in front of a cell, the more the force grows (+FORCE_INC). Once moving stops, the force will decrease (-FORCE_DESC):
  mg.setForces(100 /*MAX_FORCE*/, 8 /*FORCE_INC*/, 2 /*FORCE_DESC*/); 

  fnpEndSetup(); //FeedNplay screen size. Do not change! (by Tiago Martins)
}

void draw() {
  ArrayList<float[]> activeCells = mg.getActiveCells();
  if (activeCells.size() > 0) for (float[] ac : activeCells) {
    println(
    ac[0] /*CENTER_X_OF_THE_CELL*/, 
    ac[1] /*CENTER_Y_OF_THE_CELL*/, 
    ac[2] /*NUMBER_OF_ACTIVE_PIXELS_IN_THE_CELL*/, 
    ac[3] /*CURRENT_FORCE*/
    );
  }

  mg.draw(); //Just for debug. Comment this!
}
