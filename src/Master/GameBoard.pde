class GameBoard {
  Player player;
  //Timer timer;
  boolean won;
  int lives;

  // constructor
  GameBoard() {
    println("creating GameBoard "); //<>//
    player = new Player(20, 20);
    won = false;
  }

  // display board
  void display() {
    println("in gameboard diplay");
    player.show(); //<>//
  }

  void keyPressed(char k) {
    if (k == 'a' || k == 'd' || k == ' ') { // character movement
      player.setState(k);
    }
  }
}
