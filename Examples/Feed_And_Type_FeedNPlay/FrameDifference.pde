class FrameDifference {
  Capture cam;
  int[] pcam = null;
  int camWidth, camHeight;
  int ppx, numActs;
  PImage originalCam;

  FrameDifference(PApplet f, int camIndex) {
    String[] cameras = Capture.list();
    printArray(cameras);
    cam = new Capture(f, "pipeline:autovideosrc");
    cam.start();

    camWidth = cam.width;
    camHeight = cam.height;
    println("camSize:", camWidth, camHeight);

    pcam = new int[camWidth * camHeight];
    for (int i=0; i <pcam.length; i++) pcam[i] = 0;

    originalCam = cam.copy();
  }

  void draw() {
    
  //image(originalCam, 0, 0);
   image(this.cam, 0, 0);
  }

  void update() {
    if (cam.available()) {
      cam.read();
      //originalCam = cam.copy();
      cam.loadPixels();
      for (int i =0; i <cam.pixels.length; i++) {
        ppx = cam.pixels[i];
        if (abs(pcam[i] - cam.pixels[i]) > 3000000 ) { //houve movimento
          cam.pixels[i] = color(255);
          //float x = i%cam.width;
          //float y =floor(i/cam.width);
        } else cam.pixels[i] = color(0);
        pcam[i] = ppx;
      }
      cam.updatePixels();
   
    }
  }
}
