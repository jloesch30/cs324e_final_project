class Portals {
  
  // position data
  float x, y;
  
  // every 'in' portal will have an 'out' portal = p2
  Portals p2;
  
  Portals (float _x, float _y) {
    x = _x;
    y = _y;
  }
  void display() {
    fill(255, 0, 0);
    rect(x, y, 20, 20);
    if (p2 != null) {
      p2.display();
    }
    
  }
  void spwanOut(PVector pos) {
    p2 = new Portals(pos.x, pos.y);
  }
}
