class MotionGrid {
  FrameDifference fd;
  int numActsX = 10, numActsY  = 5;
  Capture cam;
  Actuator[] acts;
  int thr;
  float width, height;
  float offX = 0, offY = 0, sclX = 1, sclY = 1;
  int mode = NORMAL;
  float maxForce = 10, forceInc = 0, forceIncNeg = 0;

  MotionGrid(PApplet p, int numCellsX, int numCellsY, int thr ) {
    this.fd = new FrameDifference(p, 0);
    this.cam = fd.cam;
    //cam.resize(640,71);
    this.width = cam.width;
    this.height = cam.height;
    this.thr = thr;
    this.numActsX = numCellsX;
    this.numActsY = numCellsY;

    float w = fd.cam.width/ (float) numActsX, h = fd.cam.height/ (float)numActsY;
    acts = new Actuator[numActsX*numActsY];
    int i= 0;
    for (float x=0; x < numActsX; x+=1)
      for (float y=0; y < numActsY; y+=1) {
        acts[i] = new Actuator(fd, x*w, y*h, w, h, thr);
        i++;
      }
  }
  
  
  
  
  
  void setForces(float maxForce, float forceInc, float forceIncNeg) {
    this.maxForce = maxForce;
    this.forceInc=forceInc;
    this.forceIncNeg=forceIncNeg;
  }

  void transform(float x, float y, float w, float h) {
    //posicao
    this.offX = x;
    this.offY = y;

    //escala
    if (w!=0 && h==0) this.sclX = this.sclY = w/this.width;
    else if (h!=0 && w==0) this.sclX = this.sclY = h/this.height;
    else if (h!=0 && w!=0) {
      this.sclX = w/this.width;
      this.sclY = h/this.height;
    }

    //atualizar centrosTrans
    for (int i=0; i < acts.length; i++) {
      if (this.mode == CENTER) {
        acts[i].centerXTrans = ( (acts[i].centerX - (this.width/2) ) * -1 * this.sclX) + this.offX;
        acts[i].centerYTrans = ( (acts[i].centerY - (this.height/2) ) * this.sclY) + this.offY;
      } else {
        acts[i].centerXTrans  = ( (-acts[i].centerX+this.width) * this.sclX) + this.offX;
        acts[i].centerYTrans = ( acts[i].centerY * this.sclY) + this.offY;
      }
    }
  }

  void mode(int mode) {
    this.mode = mode;
  }

  void draw() {
    pushMatrix();

    //translate do utilizador
    translate(this.offX, this.offY);
    scale(this.sclX, this.sclY);
    if (this.mode==CENTER) translate(-(this.width/2), -(this.height/2));

    //flip cam
    translate(this.width, 0);
    scale(-1, 1);

    fd.draw();
    for (int i=0; i < acts.length; i++) acts[i].draw();

    popMatrix();
  }

  ArrayList<float[]> getActiveCells() {
    fd.update();
    ArrayList<float[]> actives = new ArrayList<float[]>();
    for (int i=0; i < acts.length; i++) {
      float m = acts[i].movement();

      acts[i].active =  m > this.thr;

      if ( (acts[i].active && acts[i].pActive) || acts[i].pActive && acts[i].ppActive) {
        if (acts[i].force<this.maxForce) acts[i].force += this.forceInc;
      } else if ( acts[i].force > 0) acts[i].force -= this.forceIncNeg;

      acts[i].ppActive = acts[i].pActive;
      acts[i].pActive = acts[i].active;

      //passar apenas se estiver a atrair/retrair
      if (acts[i].force>0) {
        float[] info = {acts[i].centerXTrans, acts[i].centerYTrans, m, acts[i].force};
        actives.add(info);
      }
    }
    //image(fd.originalCam, 0, 0);
    return actives;
  }
}
