class Obstacle  {
  
  // positional data for wall
  int x;
  int y;
  
  // size data
  int w;
  int h;
  
  Obstacle(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void display() {
    rect(x, y, w, h);
  }
  
  // returns true of the projectile hits an obstical
  boolean checkProjectile(PVector projPos) {
    float topRight = x + w;
    float btmLeft = y + h;
    
    //boolean return if projectile is in the object
    if ((projPos.x >= x && projPos.x <= topRight) && (projPos.y >= y && projPos.y <= btmLeft)) { //<>// //<>//
      println("returning true");
      return true;
    }
    return false;
  }
}
