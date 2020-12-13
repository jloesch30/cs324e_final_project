class GUI {
  // score reader
  ScoreReader score;
  float scorePosition;
  float paddingMult;
  
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
  float x = 460;
  float y = 10;
  float w = 30;
  float h = 30;


  GUI() {
    victory = loadImage("victory.png");
    defeat = loadImage("defeat.png");
    menu = loadImage("mainMenu.png");
    pause = loadImage("paused.png");
    pauseButton = loadImage("pauseButton.png");
    
    // line spacing for scores
    paddingMult = 1.2;
    scorePosition = height/2;
    score = new ScoreReader();
  }

  void levelDisplay(float lvls) { //done
    rectMode(CENTER);
    textSize(50);
    fill(0, 162, 255); //blue
    textAlign(CENTER);
    text(str(lvls), 250, 71);
    fill(255, 93, 0); //orange
    textSize(25);
    text("Level", 250, 25);
    fill(255); // white (revert back)
  }

  void timeDisplay(float time) {
    textSize(20);
    text(str(time), 370, 30);
    textSize(15);
    text("seconds left", 370, 50);
  }
  void lvlPassed() {
    textAlign(CENTER);
    textSize(40);
    fill(255, 255, 255, alphaTxt);
    text("Level Passed", width/2, height/2);
    text("Press ENTER to continue", width/2, height/2 + 50);
  }

  void mainMenu() { //timer variable class set up for lvlpassed and victory
    imageMode(CENTER);
    image(menu, width/2 - 20, height/2);
    imageMode(CORNER);
    textAlign(CENTER);
    textSize(30);
    text("Press ENTER to start", width/2, 450);
    textAlign(CORNER);
  }
  void victoryDisplay() {
    imageMode(CENTER);
    image(victory, width/2, height/2);
    imageMode(CORNER);
  }

  void defeatDisplay() {
    image(defeat, 25, 100);
  }
  void highScoreDisplay() {
    if (score.s.size() == 0) {
      score.parseFile();
    } else {
      textAlign(CENTER);
      textSize(20);
      text("Level", 220, height/2 - 30);
      text("Time", 280, height/2 - 30);
      // display the scores here
      for (String s : score.s) {
        text(s, width/2, scorePosition);
        scorePosition *= paddingMult;
      }
      scorePosition = height/2; 
    }
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
    image(pauseButton, x, y, w, h);
  }
  boolean clickHover(int mx, int my) { //
    return (mx >= x && mx <= x+w && my >= y && my <= y+h);
  }
}
