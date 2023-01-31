class Actuator {
  float x, y, w, h, centerX, centerY;
  FrameDifference fd;
  Capture cam;
  int thr;
  float movement = 255, centerXTrans, centerYTrans;
  boolean ppActive = false, pActive = false, active = false;
  float force = 0;

  Actuator(FrameDifference p, float x, float y, float w, float h, int thr) {
    this.thr = thr;
    this.fd  = p;
    this.cam = fd.cam;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.centerX = this.x + (this.w/2);
    this.centerY = this.y + (this.h/2);

    this.centerXTrans = this.centerX;
    this.centerYTrans = this.centerY;
  }
  
  void draw() {
    stroke(255, 0, 0);
    if (this.active) fill(255, 0, 0, 127);
    else noFill();
    rect(this.x, this.y, this.w, this.h);
    
    fill(0, 255, 0);
    rect(this.x, this.y, this.w, this.h * (this.force/10));
  }


  float movement() {
    PImage movementMap = this.cam.get(floor(this.x), floor(this.y), floor(this.w), floor(this.h));
    movementMap.loadPixels();
    int sum = 0;
    for (int i=0; i <movementMap.pixels.length; i++) {
      sum+= brightness(movementMap.pixels[i]);
    }
    this.movement = sum/movementMap.pixels.length;
    return this.movement;
  }
}
