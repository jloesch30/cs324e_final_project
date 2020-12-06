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
  PVector hitBoxUp;
  PVector hitBoxRight;
  PVector hitBoxDown;
  PVector hitBoxLeft;
  PVector[][] hitBox;

  // mass
  float mass;

  // portal gun
  PortalGun pg;

  Player(float x, float y) {
    // position and hitbox
    position = new PVector(x, y);

    // mass and forces
    mass = 10.0;
    jumpForce = new PVector(0, - 1.3);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, 0.15 * mass);

    // animation variables and movement keys
    currFrame = 1;
    animations = new Animations();
    timer = new Timer();
    keys = new boolean[3];
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    currAnimation = animations.idle;

    // timer
    timer.start();

    // portalgun
    pg = new PortalGun();
  }
  void display(ArrayList<Obstacle> objs) {
    pushMatrix();
    pg.display(objs); // 2 levels of higharchy
    translate(position.x, position.y);
    if (keys[0] && keys[1]) {
      scale(1.0, 1.0);
    } else if (keys[0]) { // player moving left, flip position to mimic turn around
      scale( - 1.0, 1.0);
    } else { 
      scale(1.0, 1.0);
    }
    animate();
    popMatrix();

    // remove me
    ellipse(position.x - 8, position.y - 23, 10, 10); // top
    ellipse(position.x + 8, position.y, 10, 10); // right
    ellipse(position.x - 8, position.y + 20, 10, 10); // down
    ellipse(position.x - 8, position.y, 10, 10); // left
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
  void activateActionState(char k) {
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

    //updateHitBox
    updateHitBox();

    // image render
    float timeElapsed = timer.getElapsedTime();
    PImage frame = currAnimation[currFrame];
    frame.resize(60, 60);
    imageMode(CENTER);
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
      position.y = 441.0; // reposition player on the object
      gravity.y = 0.0; // turn off gravity
    } else {
      gravity.y = 0.15 * mass;
    }
  }
  void updateHitBox() {
  }
}
