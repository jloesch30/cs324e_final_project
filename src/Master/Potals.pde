class Portals {
  // position data
  float x, y;
  int size;
  PVector corner;
  
  // in or out portal
  boolean in;
  
  // shape
  PImage s;
  
  Portals (float _x, float _y, boolean _in) {
    x = _x;
    y = _y;
    in = _in;
    size = 40;
    if (in) {
      s = loadImage("data/portal_shape_in.png");
      corner = new PVector((x-(size/2)), (y-(size/2)));
    } else {
      s = loadImage("data/portal_shape_out.png");
    }
    s.resize(size, size);
  }
  void display() {
    imageMode(CENTER);
    image(s, x, y);
  }
  boolean inside (PVector[][] hitBox) {
    PVector hitBoxRight = hitBox[0][1];
    PVector hitBoxLeft = hitBox[1][1];
    PVector hitBoxDown = hitBox[1][0];
    if ((hitBoxRight.x >= corner.x &&  hitBoxRight.x <= corner.x + size) && (hitBoxRight.y >= corner.y &&  hitBoxRight.y <= corner.y + size)) {
      // if hitBoxRight inside
      return true;
    } else if ((hitBoxLeft.x >= corner.x &&  hitBoxLeft.x <= corner.x + size) && (hitBoxLeft.y >= corner.y &&  hitBoxLeft.y <= corner.y + size)) {
      // if hitBoxLeft inside
      return true;
    } else if ((hitBoxDown.x >= corner.x &&  hitBoxDown.x <= corner.x + size) && (hitBoxDown.y >= corner.y &&  hitBoxDown.y <= corner.y + size)) {
      // hitBoxDown inside
      return true;
    }
    return false;
  }
}
