class Exit {
  int posX;
  int posY;
  PShape e;
  
  Exit(int x, int y) {
    posX = x;
    posY = y;
    e = createShape(RECT, posX, posY, 10, 20);
  }
  void display() {
    shape(e);
  }
  boolean playerReachedExit() {
    //TODO: if player enters the exit space, return true
    return true;
  }
}
