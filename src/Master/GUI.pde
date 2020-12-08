class GUI {
  PImage menu;
  PImage victory;
  PImage defeat;
  PShape life;
  PImage pause;
  PImage pauseButton;
  //PImage pause; //this might be a keypress
  int alphaTxt = 100;
  int fadeTime = 2;


  GUI() {
    victory = loadImage("victory.png");
    defeat = loadImage("defeat.png");
    menu = loadImage("mainMenu.png");
    life = loadShape("portalLives.svg");
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

  void livesDisplay(int lives) { //done
    int x = 20;
    for (int i = 1; i <= lives; i += 1) {
      shape(life, x, 10, 30, 30);
      x += 32;
    }
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
  
  void highScore(float timer) {
    textSize(20);
    text("time to beat: " + str(timer), 320,320);
  }
  void pauseMenu () {
    image(pause, 25,100);
  }
  void pauseButton () {
    image (pauseButton, 200, 10);
    
  }
}
