class Frase {
  float x, y, w, lineHeight, kerning, txtSize;
  String frase;
  String[] fraseArr;
  Letra[] letras;

  Frase(String frase, float x, float y, float w, float txtSize, float lineHeight) {
    this.frase = frase;
    this.fraseArr = frase.split("");
    this.x= x;
    this.y = y;
    this.w = w;
    this.lineHeight = lineHeight;
    this.txtSize = txtSize;
    letras = new Letra[fraseArr.length];
    this.kerning = 0.05 * this.txtSize;

    //meter letras no sitio e criar objetos Letra
    float letraX = x, letraY = this.lineHeight;
    for (int i=0; i < this.fraseArr.length; i++) {
      String s = this.fraseArr[i];
      this.letras[i] =  new Letra(s, letraX, letraY);
      this.letras[i].draw();

      if (this.letras[i].s.equals(" ") && letraX == x);
      else
        letraX+=textWidth(s)+this.kerning;

      if (letraX > this.w/* - this.x*/  || this.letras[i].s.equals("\n")) {
        letraX = x;
        letraY += this.lineHeight;
      }
    }
  }

  void updateLetra(int letraIndex, float offX, float offY) {
    this.letras[letraIndex].update(offX, offY);
  }

  void draw() {
    for (Letra l : letras) l.draw();
  }
}
