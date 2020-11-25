// Master file - this module will run the entire game
GameBoard g;

void setup() {
  println("setting up");
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
