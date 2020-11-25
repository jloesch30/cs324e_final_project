class GameBoard {
  Player player;
  //Timer timer;
  boolean won;
  int lives;

  // constructor
  GameBoard() { //<>//
    player = new Player(300, 300);
    won = false;
  }

  // display board
  void display() {
    player.show();
  }
 //<>//
  void keyPressed(char k) {
    if (k == 'a' || k == 'd' || k == ' ') { // character movement pressed
      player.activateActionState(k);
    }
  }
  void keyReleased(char k) {
    if (k == 'a' || k == 'd' || k == ' ') { // character movement released
      player.deactivateActionState(k);
    }
  }
}
