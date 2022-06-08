class MotionGrid {
  FrameDifference fd;
  int numActsX = 10, numActsY  = 5;
  Capture cam;
  Actuator[] acts;
  int thr;

  MotionGrid(PApplet p, int numCellsX, int numCellsY, int thr ) {
    this.fd = new FrameDifference(p, 0);
    this.thr = thr;
    this.numActsX = numCellsX;
    this.numActsY = numCellsY;

    int w = fd.cam.width/numActsX, h  = fd.cam.height/numActsY;
    acts = new Actuator[numActsX*numActsY];
    int i= 0;
    for (int x=0; x < numActsX; x++)
      for (int y=0; y < numActsY; y++) {
        acts[i] = new Actuator(fd, x*w, y*h, w, h, thr);
        i++;
      }
  }

  void draw() {
    fd.draw();
    for (int i=0; i < acts.length; i++) acts[i].draw();
  }

  ArrayList<float[]> getActiveCells() {
    ArrayList<float[]> actives = new ArrayList<float[]>();
    for (int i=0; i < acts.length; i++) {
      float m = acts[i].movement();
      if (m < this.thr) {
        float[] info = {acts[i].centerX, acts[i].centerY, m};
        actives.add(info);
      }
    }
    return actives;
  }
}
