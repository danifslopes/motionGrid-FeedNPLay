import processing.video.*;
MotionGrid mg;

PFont f;
float txtSize =  48, kerning = 0.05*txtSize, rel;
float marginLeft = txtSize*.4;
Frase frase;
float attractionDist = 100;

void setup() {
  fullScreen();
  //size(1400, 600);
  frameRate(60);
  //smooth();

  mg = new MotionGrid(this, 30, 20, 5); //num celulas x. num celulas y 5 de sensibilidade
  mg.mode(CENTER);
  mg.transform(width/2, height/2+(height/15), width, height*1.5); //0
  mg.setForces(100, 8, 2); //maxForce, forceInc, forceIncNeg

  f = loadFont("KyivTypeSans_Bold3-48.vlw");
  //f = loadFont("Constantia-200.vlw");
  textFont(f);
  textSize(txtSize);

  String txt = "";
  String[] lines = loadStrings("text.txt");
  for (int i = 0; i < lines.length; i++) txt+=lines[i] + "\n";
  frase = new Frase(txt, marginLeft, 0, width-marginLeft*2, txtSize, txtSize*1.125);
}

void draw() {
  background(0);
  ArrayList<float[]> activeCells = mg.getActiveCells();

  //mg.draw();
  fill(255);


  //LETRAS

  for (Letra l : frase.letras) {
    PVector pos = new PVector(l.x, l.y);
    PVector finalDir = new PVector(0, 0);

    if (activeCells.size() > 0) for (float[] ac : activeCells) {
      PVector mouse = new PVector(ac[0], ac[1]);
      PVector dir = mouse.copy().sub(pos);
      if (dir.mag() < attractionDist) {
        dir.normalize();
        dir.mult(1+ ac[3]);
        finalDir.sub(dir);
      }
    }

    l.update(finalDir.x, finalDir.y);
  }

  frase.draw();
}
