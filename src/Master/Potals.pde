class Portals {
  
  // position data
  float x, y;
  
  // in or out portal
  boolean in;
  
  // shape
  PShape s;
  
  Portals (float _x, float _y, boolean _in) {
    x = _x;
    y = _y;
    in = _in;
    if (in) {
      s = createShape(RECT, x, y, 10, 10);
      s.setFill(color(0, 0, 255));
    } else {
      s = createShape(RECT, x, y, 10, 10);
      s.setFill(color(255, 0, 0));
    }
  }
  void display() {
    shape(s);
  }
}
