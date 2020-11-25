class Player {
	/* this class will handle all player interactions, we will include the
	sprite loading in class Animations 
  note: I had a hard time figuring out the extends functionality, it was
  giving me recursive calls when I was trying to reference the master class :(
  Hopfully this is okay but feel free to change anything! 
  */
	int x, y;
  int currFrame;
	PImage[] currAnimation;
	boolean runningLeft, runningRight, running, jump, idle;
  boolean action;
  boolean keys[]; // [0]: runLeft [1]: runRight [2] jump
  Animations animations;
  Timer timer;
	
	Player(int _x, int _y) {
		// starting position of player (spawn location)
		x = _x;
		y = _y;
    currFrame = 1;
		runningLeft = false;
		runningRight = false;
    running = true;
		jump = false;
    animations = new Animations();
    timer = new Timer();
    keys = new boolean[3];
    keys[0] = false;
    keys[1] = false;
    keys[2]= false;
    timer.start();
    currAnimation = animations.idle;
	}
	void show() {
    pushMatrix();
    translate(x, y);
    if (keys[0] && keys[1]) { // both a and d pressed
      scale(1.0, 1.0);
    } else if (keys[0]) { // only a pressed
      scale(-1.0, 1.0);
    } else { // only d pressed or none
      scale(1.0, 1.0);
    }
		animate();
    popMatrix();
	}
  void deactivateActionState(char k) {
    if (k == ' ') {
        keys[2] = false; // jump
    } else if (k == 'a') {
        keys[0] = false; // run left
    } else if (k == 'd') {
        keys[1] = false; // run right
    }
  }
	void activateActionState (char k) {
		if (k == ' ') {
        keys[2] = true; // jump
		} else if (k == 'a') {
  			keys[0] = true; // run left
		} else if (k == 'd') {
        keys[1] = true; // run right
		}
   }
    void animate() {
        /* 
        This function handles the animation frames and moving the player (changing x and y)
        */
        
        // key combos
        if (keys[0] && !(keys[1]) && !(keys[2])) { // left pressed
          currAnimation = animations.run;
          moveLeft();
        } else if (!(keys[0]) && keys[1] && !(keys[2])) { // right pressed
          currAnimation = animations.run;
          moveRight();
        } else if (keys[0] && !(keys[1]) && keys[2]) { // left, jump pressed
          currAnimation = animations.jump;
          moveLeftJump();
        } else if (!(keys[0]) && keys[1] && keys[2]) { // right, jump pressed
          currAnimation = animations.jump;
          moveRightJump();
        } else if (!(keys[0]) && !(keys[1]) && keys[2]) { // jump pressed
          currAnimation = animations.jump;
          moveJump();
        } else {
          currAnimation = animations.idle; // other or nothing pressed
        }
        
        // image render
        float timeElapsed = timer.getElapsedTime();
        PImage frame = currAnimation[currFrame];
        frame.resize(60,60);
        imageMode(CORNER);
        image(frame, 0, 0);
        if ((timeElapsed - animations.animationTimer) >= animations.animationTimerVal) {
            currFrame = (currFrame + 1) % animations.actionFrames;
            animations.animationTimer = timer.getElapsedTime();
        }
    }
    
    /*
    movement functions below
    */
    
    void moveLeft() {
      x -= 1;
    }
    void moveRight() {
      x += 1;
    }
    void moveLeftJump() {
      x -= 1;
      y -= 1;
    }
    void moveRightJump() {
      x += 1;
      y -= 1;
    }
    void moveJump() {
      y -= 1;
    }
}
