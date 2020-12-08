class Exit {
  // size data
  int x;
  int y;
  int w;
  int h;
  
  // shape
  PShape e;
  
  Exit(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    e = createShape(RECT, x, y, w, h);
    e.setFill(color(255, 0, 0));
  }
  void display() {
    shape(e);
  }
}
