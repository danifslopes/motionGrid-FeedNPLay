import processing.video.*;
MotionGrid mg;

void setup() {
  fullScreen(2);
  //size(1400, 600);
  mg = new MotionGrid(this, 20, 10, 250);
}

void draw() {
  ArrayList<float[]> activeCells = mg.getActiveCells();
  if(activeCells.size() > 0) println(activeCells.get(0));
  
  mg.draw();
}
