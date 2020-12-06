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
    if ((projPos.x >= x && projPos.x <= topRight) && (projPos.y >= y && projPos.y <= btmLeft)) { //<>//
      return true;
    }
    return false;
  }
  
  // player checks
  String checkTop(PVector hitBox) {
    if ((hitBox.x >= x && hitBox.x <= x + w) && (hitBox.y >= y && hitBox.y <= y + h )) { // check player top
      return "true";
    }
    return "false";
  }
  String checkRight(PVector hitBox) {
    if ((hitBox.x >= x && hitBox.x <= x + w) && (hitBox.y >= y && hitBox.y <= y + h )) { // check player top
      return "true";
    }
    return "false";
  }
  String checkLeft(PVector hitBox) {
    if ((hitBox.x >= x && hitBox.x <= x + w) && (hitBox.y >= y && hitBox.y <= y + h )) { // check player top
      return "true";
    }
    return "false";
  }
}
