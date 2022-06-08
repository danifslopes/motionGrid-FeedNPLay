class FrameDifference {
  Capture cam;
  int[] pcam = null;
  int camWidth, camHeight;
  int ppx, numActs;

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
  }

  void draw() {
    if (cam.available()) {
      cam.read();
      cam.loadPixels();
      for (int i =0; i <cam.pixels.length; i++) {
        ppx = cam.pixels[i];
        if (abs(pcam[i] - cam.pixels[i]) > 3000000 ) { //houve movimento
          cam.pixels[i] = color(0);
          //float x = i%cam.width;
          //float y =floor(i/cam.width);
        } else cam.pixels[i] = color(255);
        pcam[i] = ppx;
      }
      cam.updatePixels();
    }
    image(cam, 0, 0);
  }
}
