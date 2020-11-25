class Animations {
  PImage[] idle;
  PImage[] jump;
  PImage[] run;
  String folder;
  int actionFrames = 15;
  int animationTimerVal = 50;
  int animationTimer = 0;

  Animations() {
    folder = "spriteImgs/";

    idle = new PImage[actionFrames];
    for (int i = 0; i < idle.length; i++) {
      String name = folder + "Idle (" + nf(i + 1, 0) + ").png";
      idle[i] = loadImage(name);
    }
    run = new PImage[actionFrames];
    for (int i = 0; i < run.length; i++) {
      String name = folder + "Run (" + nf(i + 1, 0) + ").png";
      run[i] = loadImage(name);
    }
    jump = new PImage[actionFrames];
    for (int i = 0; i < jump.length; i++) {
      String name = folder + "Jump (" + nf(i + 1, 0) + ").png";
      jump[i] = loadImage(name);
    }
  }
}
