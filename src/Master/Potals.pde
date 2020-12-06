class Portals {
  // position data
  float x, y;
  
  // in or out portal
  boolean in;
  
  // shape
  PImage s;
  
  Portals (float _x, float _y, boolean _in) {
    x = _x;
    y = _y;
    in = _in;
    if (in) {
      s = loadImage("data/portal_shape_in.png");
    } else {
      s = loadImage("data/portal_shape_out.png");
    }
    s.resize(40, 40);
  }
  void display() {
    imageMode(CENTER);
    image(s, x, y);
  }
}
