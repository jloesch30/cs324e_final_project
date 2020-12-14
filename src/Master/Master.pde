// Master file - this module will run the entire game //<>//
import processing.sound.*;
GameSound sound;
GUI gui;

GameBoard g;
PImage backgroundImg;
boolean music;

void setup() {
  // game set-up
  g = new GameBoard();
  gui = new GUI();
  size(500, 500);
  backgroundImg = loadImage("background.png");
  backgroundImg.resize(500, 500);
  testbranchmarilia
  sound = new GameSound(this);
  //r = new MapReader();
  //r.readMap(0);
  sound.loop();
  music = true;
}

void draw() {
  background(backgroundImg);
  g.display();
  //gui.muteButton();

  //if(music == true){
  //  hoverMute


  //} 

  if (g.restart == true) {
    g = new GameBoard();
  }

  background(backgroundImg);  
  g.display();
}
void mousePressed() {
  g.mousePressed();
  boolean muteClick = gui.hoverMute(mouseX, mouseY);
  if (muteClick) {      
    gui.mPress = true;
    gui.hover = false;
    if (music == true) {
      sound.pause();
      music = false;
    } else {
      sound.play();
      music = true;
    }
  }
}

void keyPressed() {
  char k = key;
  g.keyPressed(k);
}

void keyReleased() {
  char k = key;
  g.keyReleased(k);
}



void mouseReleased() {
  g.gui.mPress = false;
  gui.mPress = false;
}
