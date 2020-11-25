class Player {
	/* this class will handle all player interactions, we will include the
	sprite loading here as well as animation handling */
	int x, y;
  int currFrame;
	PImage[] currAnimation;
	boolean runningLeft, runningRight, jumping, idle;
  Animations animations;
  Timer timer;
	
	Player(int _x, int _y) {
    println("creating player");
		// starting position of player (spawn location)
		x = _x;
		y = _y;
    currFrame = 1;
		runningLeft = false;
		runningRight = false;
		jumping = false;
		idle = true;
    animations = new Animations();
    timer = new Timer();
    timer.start();
    currAnimation = animations.idle;
	}
	void show() {
    println("in show");
		// show the player in various states
    pushMatrix();
    translate(width/2, height/2);
		animate();
    popMatrix();
	}
	void setState(char k) {
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
		} else {
            currAnimation = animations.idle;
        }
	}
    void animate() {
        float timeElapsed = timer.getElapsedTime();
        println("time elapsed " + timeElapsed); 
        imageMode(CENTER);
        println("we are animating");
        // show the image and run the timer
        image(currAnimation[currFrame], 0, 0);
        if ((timeElapsed - animations.animationTimer) >= animations.animationTimerVal) {
            println("changing frame");
            currFrame = (currFrame + 1) % animations.actionFrames;
            animations.animationTimer = timer.getElapsedTime();
        }
    }
}
