class Letra {
  float x, y, offX, offY;
  String s;

  Letra(String s, float x, float y) {
    this.s=s;
    this.x=x;
    this.y = y;
  }

  void update(float offX, float offY) {
    this.offX = offX;
    this.offY = offY;
  }

  void draw() {
    text(this.s, this.x + this.offX, this.y + this.offY);
  }
}
