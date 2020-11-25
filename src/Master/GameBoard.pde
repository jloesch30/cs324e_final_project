class GameBoard {
  Player player;
  //Timer timer;
  boolean won;
  int lives;

  // constructor
  GameBoard() { //<>//
    player = new Player(20, 20);
    won = false;
  }

  // display board
  void display() {
    player.show();
  }
 //<>//
  void keyPressed(char k) {
    if (k == 'a' || k == 'd' || k == ' ') { // character movement pressed
      player.setActionState(k);
    }
  }
  void keyReleased(char k) {
    if (k == 'a' || k == 'd' || k == ' ') { // character movement released
      player.setIdleState();
    }
  }
}
