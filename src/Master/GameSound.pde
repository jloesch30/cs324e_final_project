class GameSound {
  SoundFile clickSound;

  GameSound(PApplet p) {
    clickSound = new SoundFile(p, "gameSound.wav");
    clickSound.amp(0.5);
  }
  void play() {
    clickSound.play();
  }
    void pause() {
    clickSound.pause();
  }
    void loop() {
    clickSound.loop();
  }
}
