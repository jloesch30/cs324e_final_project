// Master file - this module will run the entire game
GameBoard g;
PImage backgroundImg;

void setup() {
	// game set-up
	g = new GameBoard();
	size(500, 500);
  backgroundImg = loadImage("background.png");
  backgroundImg.resize(500,500);
}

void draw() {

  background(backgroundImg);
	g.display();

	// exit example
	fill(255, 0, 0);
	rect(420, 85, 20, 5);
	fill(255);
}

void keyPressed() {
	char k = key;
	g.keyPressed(k);
}

void keyReleased() {
  char k = key;
  g.keyReleased(k);
}

void mousePressed() {
  g.mousePressed();
}
