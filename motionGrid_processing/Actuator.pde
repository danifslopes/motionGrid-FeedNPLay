class Actuator {
  int x, y, w, h, centerX, centerY;
  FrameDifference fd;
  Capture cam;
  int thr;
  float movement = 255;

  Actuator(FrameDifference p, int x, int y, int w, int h, int thr) {
    this.thr = thr;
    this.fd  = p;
    this.cam = fd.cam;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.centerX = this.x + (this.w/2);
    this.centerY = this.y + (this.h/2);
  }

  void draw() {
    stroke(255, 0, 0);
    if (this.movement < this.thr ) fill(255, 0, 0, 127);
    else noFill();
    rect(this.x, this.y, this.w, this.h);
  }


  float movement() {
    PImage movementMap = this.cam.get(this.x, this.y, this.w, this.h);
    movementMap.loadPixels();
    int sum = 0;
    for (int i=0; i <movementMap.pixels.length; i++) {
      sum+= brightness(movementMap.pixels[i]);
    }
    this.movement = sum/movementMap.pixels.length;
    return this.movement;
  }
}
