class GUI {
  PImage menu;
  PImage victory;
  PImage defeat;
  PImage pause;
  PImage pauseButton;
  //PImage pause; //this might be a keypress
  int alphaTxt = 100;
  int fadeTime = 2;
  boolean mPress = false;
  boolean hover = false;
  color col = color(0,0,0);
  float x = 300;
  float y = 10;
  float w = 30;
  float h = 30;


  GUI() {
    victory = loadImage("victory.png");
    defeat = loadImage("defeat.png");
    menu = loadImage("mainMenu.png");
    pause = loadImage("paused.png");
    pauseButton = loadImage("pauseButton.png");
  }

  void levelDisplay(float lvls) { //done
    rectMode(CENTER);
    textSize(50);
    fill(0, 162, 255); //blue
    textAlign(CENTER);
    text(str(lvls), 250, 71);
    fill(255, 93, 0); //orange
    textSize(25);
    text("Level", 220, 25);
  }

  void lvlPassed() {
    //for (int i = 0; i <= alphaTxt; i *= -1)  { //setup a timer variable later for fading
    //alphaTxt += i;
    textSize(40);
    fill(255, 255, 255, alphaTxt);
    text("Level Passed", width/2, height/2);
  }

  void mainMenu() { //timer variable class set up for lvlpassed and victory 
    image(menu, 25, 100);
  }
  void victoryDisplay() {
    image(victory, 25, 100);
  }

  void defeatDisplay() {
    image(defeat, 25, 100);
  }
 
  void highScoreDisplay() {
  }
  void pauseMenu () {
    image(pause, 25, 100);
  }

  // pause button and display when it get clicked on and pause display
  void updateColor(int r, int g, int b) {
    col = color(r, g, b);
  } 

  void pauseButton () {
    ellipseMode(CORNER);
    noStroke();
    if (this.hover) {
      fill(200,100,50);
      ellipse(x,y,w,h);
    } else {
      fill(col);
      ellipse(x,y,w,h);
    }
    fill(255); //changes all the other objects back to white and keep the if changes of orange limited to pause
    image (pauseButton, x, y, w, h);
  }
  boolean clickHover(int mx, int my) { //
    return (mx >= x && mx <= x+w && my >= y && my <= y+h);
  }
}
