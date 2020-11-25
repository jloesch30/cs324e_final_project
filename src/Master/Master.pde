// Master file - this module will run the entire game
GameBoard g;

void setup() {
	// game set-up
	g = new GameBoard();
	size(500, 500);
}

void draw() {
  background(0);
	g.display();
}

void keyPressed() {
	char k = key;
	g.keyPressed(k);
}

void keyReleased() {
  char k = key;
  g.keyReleased(k);
}
