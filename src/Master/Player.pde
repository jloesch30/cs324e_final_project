class Player {
	/* this class will handle all player interactions, we will include the
	sprite loading here as well as animation handling */
	int x, y;
  int currFrame;
	PImage[] currAnimation;
	boolean runningLeft, runningRight, jumping, idle;
  boolean action;
  Animations animations;
  Timer timer;
	
	Player(int _x, int _y) {
		// starting position of player (spawn location)
		x = _x;
		y = _y;
    currFrame = 1;
		runningLeft = false;
		runningRight = false;
		jumping = false;
		idle = true;
    action = false;
    animations = new Animations();
    timer = new Timer();
    timer.start();
    currAnimation = animations.idle;
	}
	void show() {
		// show the player in various states
    pushMatrix();
    translate(width/2, height/2);
		animate();
    popMatrix();
    action = false;
	}
  void setIdleState() {
    currAnimation = animations.idle;
  }
	void setActionState (char k) {
		// set state of the player (run, jump, idle)
		if (k == ' ') {
			currAnimation = animations.jump;
		} else if (k == 'a') {
			currAnimation = animations.run;
			runningLeft = true;
			runningRight = false;
		} else if (k == 'd') {
            currAnimation = animations.run;
			runningRight = true;
			runningLeft = false;
		}
	}
    void animate() {
        float timeElapsed = timer.getElapsedTime();
        PImage frame = currAnimation[currFrame];
        frame.resize(60,60);
        imageMode(CENTER);
        // show the image and run the timer
        image(frame, 0, 0);
        if ((timeElapsed - animations.animationTimer) >= animations.animationTimerVal) {
            currFrame = (currFrame + 1) % animations.actionFrames;
            animations.animationTimer = timer.getElapsedTime();
        }
    }
}
