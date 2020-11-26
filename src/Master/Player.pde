class Player {
	/* this class will handle all player interactions, we will include the
	sprite loading in class Animations 
  note: I had a hard time figuring out the extends functionality, it was
  giving me recursive calls when I was trying to reference the master class :(
  Hopfully this is okay but feel free to change anything! 
  */
  PVector position;
  int currFrame;
	PImage[] currAnimation;
	boolean runningLeft, runningRight, running, jump, idle;
  boolean action;
  boolean keys[]; // [0]: runLeft [1]: runRight [2] jump
  Animations animations;
  Timer timer;
  
  // forces
  PVector velocity;
  PVector acceleration;
  PVector gravity;
  PVector jumpForce;
  
  // mass
  float mass;
	
	Player(float x, float y) {
    position = new PVector(x, y);
    // mass and forces
    mass = 10.0;
    jumpForce = new PVector(0, -15.0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, 0.15*mass);
    // animation variables and movement keys
    currFrame = 1;
    animations = new Animations();
    timer = new Timer();
    keys = new boolean[3];
    keys[0] = false;
    keys[1] = false;
    keys[2]= false;
    currAnimation = animations.idle;
    // timer
    timer.start();
	}
	void show() {
    pushMatrix();
    translate(position.x, position.y);
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
        applyForce(gravity);
        
        // key combos
        if (keys[0] && !(keys[1]) && !(keys[2])) { // left pressed
          currAnimation = animations.run;
          position.x -= 1;
        } else if (!(keys[0]) && keys[1] && !(keys[2])) { // right pressed
          currAnimation = animations.run;
          position.x += 1;
        } else if (keys[0] && !(keys[1]) && keys[2]) { // left, jump pressed
          currAnimation = animations.jump;
          position.x -= 1;
          applyForce(jumpForce);
        } else if (!(keys[0]) && keys[1] && keys[2]) { // right, jump pressed
          currAnimation = animations.jump;
          position.x += 1;
          applyForce(jumpForce);
        } else if (!(keys[0]) && !(keys[1]) && keys[2]) { // jump pressed
          currAnimation = animations.jump;
          applyForce(jumpForce);
        } else {
          currAnimation = animations.idle; // other or nothing pressed
        }
        
        // update forces
        update();
        
        // checkEdge
        checkEdge();
        
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
    void applyForce(PVector force) {
      // A = F/M 
      PVector f = PVector.div(force, mass);
      // accumulate forces in acceleration
      acceleration.add(f);
    }
    void update() {
      velocity.add(acceleration);
      position.add(velocity);
      // clear acceleration each frame
      acceleration.mult(0);
    }
    
    void checkEdge() {
      println("gravity is: " + gravity.y);
      if (position.y > height - 51) {
        println("image at floor, position is: " + position.y + " and height is: " + height);
        position.y = height - 50;
        gravity.y = 0.0;
      } else {
        gravity.y = 0.15*mass;
      }
    }
}
