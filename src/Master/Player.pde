class Player {
  // timer
  Timer timer;
  
  // animation variables, movement keys
  int currFrame;
  PImage[] currAnimation;
  boolean runningLeft, runningRight, running, jump, idle;
  boolean keys[]; // [0]: runLeft [1]: runRight [2] jump
  Animations animations;
  
  // forces and position
  PVector velocity;
  PVector acceleration;
  PVector gravity;
  PVector jumpForce;
  PVector position;
  
  // mass
  float mass;
  
  // projectiles
  ArrayList<Projectile> projectiles;
	
	Player(float x, float y) {
    position = new PVector(x, y);
    
    // mass and forces
    mass = 10.0;
    jumpForce = new PVector(0, -1.3);
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
    
    // projectiles
    projectiles = new ArrayList<Projectile>();
	}
	void show() {
    pushMatrix();
    translate(position.x, position.y);
    if (keys[0] && keys[1]) {
      scale(1.0, 1.0);
    } else if (keys[0]) { // player moving left, flip position to mimic turn around
      scale(-1.0, 1.0);
    } else { 
      scale(1.0, 1.0);
    }
		animate();
    popMatrix();
    
    // projectile handling
    if (!(projectiles.size() < 1)) {
      fireProjectiles();
    }
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
      PVector f = PVector.div(force, mass); // A = F/M 
      acceleration.add(f); // accumulate forces in acceleration
    }
    void update() {
      velocity.add(acceleration);
      position.add(velocity);
      acceleration.mult(0); // clear acceleration each frame
    }
    
    void checkEdge() {
      if (position.y > height - 60) {
        //println("image at floor, position is: " + position.y + " and height is: " + height);
        position.y = 441.0; // reposition player on the object
        gravity.y = 0.0; // turn off gravity
      } else {
        gravity.y = 0.15*mass;
      }
    }
    void fireProjectiles() {
      ArrayList<Projectile> pCopy = new ArrayList<Projectile>(projectiles);
      for (Projectile p: pCopy) {
        p.display();
        boolean destroy = p.complete();
        //println("destroy is: " + destroy);
        if (destroy) {
          projectiles.remove(p);
        }
      }
    }
    void spawnProjectile() {
      println("projectile spawned");
      PVector startPos = new PVector(position.x, position.y);
      println("start position is: " + startPos.x + ", " + startPos.y);
      Projectile p = new Projectile(startPos, new PVector(mouseX, mouseY));
      projectiles.add(p);
    }
}
