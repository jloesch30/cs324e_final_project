/* the jump functionality has been removed temporaraly to work on other things */

class Player {
  // timer
  Timer timer;

  // animation variables, movement keys
  int currFrame;
  PImage[] currAnimation;
  boolean runningLeft, runningRight, running, jump, idle;
  boolean[] keys; // [0]: runLeft [1]: runRight [2] jump
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
  boolean grav;

  // mass
  float mass;

  // portal gun
  PortalGun pg;
  
  // collision
  boolean walkRight, walkLeft, fall, floor;
  
  // gameState
  boolean wonLevel;
  boolean saveGame;
  

  Player(float x, float y) {
    // position and hitbox
    position = new PVector(x, y);
    hitBox = new PVector[2][2];
    hitBoxUp = new PVector(position.x - 8, position.y - 23);
    hitBoxRight = new PVector(position.x + 8, position.y);
    hitBoxDown = new PVector(position.x - 8, position.y + 20);
    hitBoxLeft = new PVector(position.x - 8, position.y);
    hitBox[0][0] = hitBoxUp;
    hitBox[0][1] = hitBoxRight;
    hitBox[1][0] = hitBoxDown;
    hitBox[1][1] = hitBoxLeft;
    walkRight = true;
    walkLeft = true;
    fall = true;
    floor = false;

    // mass and forces
    mass = 10.0;
    jumpForce = new PVector(0, -10.0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, 0.15 * mass);
    grav = true;

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
    
    // gameState
    wonLevel = false;
    saveGame = true;
  }
  void display(ArrayList<Obstacle> objs, Exit e) {
    pushMatrix();
    pg.display(objs); // 2 levels of higharchy
    translate(position.x, position.y);
    pg.displayGun(keys); // show an image of the gun
    if (keys[0] && keys[1]) {
      scale(1.0, 1.0);
    } else if (keys[0]) { // player moving left, flip position to mimic turn around
      scale( - 1.0, 1.0);
    } else { 
      scale(1.0, 1.0);
    }
    animate(objs, e);
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
  void activateActionState(char k) {
    if (k == ' ') {
      keys[2] = true; // jump
    } else if (k == 'a') {
      keys[0] = true; // run left
    } else if (k == 'd') {
      keys[1] = true; // run right
    }
  }
  void animate(ArrayList<Obstacle> objs, Exit e) {
    /* This function handles the animation frames and moving the player (changing x and y) */
    
    if (fall || (!(floor))) {
      applyForce(gravity);
    }
   
    // key combos
    if (keys[0] && !(keys[1]) && !(keys[2])) { // left pressed
      if (walkLeft) {
        position.x -= 1;
      }
      currAnimation = animations.run;
    } else if (!(keys[0]) && keys[1] && !(keys[2])) { // right pressed
      if (walkRight) {
        position.x += 1;
      }
      currAnimation = animations.run;
    } else {
      currAnimation = animations.idle; // other or nothing pressed
    }

    // update forces (this is where forces are applied)
    update();
    
    //updateHitBox
    updateHitBox();
    
    // checkPortals
    boolean playerTouchedPortal= checkPortals();
    
    // check for exit
    boolean playerTouchedExit = checkExit(e);
    
    // checkEdges
    if ((!(playerTouchedPortal)) && (!(playerTouchedExit))) {
      checkEdges(objs);
    } else if (playerTouchedPortal) {
      transportPlayer(); // change the position of the player if they have entered a portal
    } else if (playerTouchedExit) {
      wonLevel = true;
    }

    // image render
    float timeElapsed = timer.getElapsedTime();
    PImage frame = currAnimation[currFrame];
    frame.resize(60, 60);
    imageMode(CENTER);
    image(frame, 0, 0);
    imageMode(CORNER);
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
    // if the player is on the floor, or standing on an obstacle, cancel forces
    if (floor || (!(fall))) {
      acceleration.mult(0.0);
      velocity.mult(0.0);
    }
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0); // clear acceleration each frame
  }

  void checkEdges(ArrayList<Obstacle> objs) {
    // colission arrays for each object
    ArrayList<String> right = new ArrayList<String>();
    ArrayList<String> left = new ArrayList<String>();
    ArrayList<String> down = new ArrayList<String>();
    // check collision with obstacles
    for (Obstacle o : objs) {
      String r = o.checkLeft(hitBoxRight);
      String l = o.checkRight(hitBoxLeft);
      String f = o.checkTop(hitBoxDown);
      right.add(r);
      left.add(l);
      down.add(f);
    }
    if (right.contains("true")) {
      walkRight = false;
    } else {
      walkRight = true;
    }
    if (left.contains("true")) {
      walkLeft = false;
    } else {
      walkLeft = true;
    }
    if (down.contains("true")) {
      fall = false;
    } else {
      fall = true;
    }
    
    // check floor
    if (hitBoxDown.y > height-5) {
      floor = true;
    } else {
      floor = false;
    }
  }
  void updateHitBox() {
    hitBoxUp.x = position.x - 8;
    hitBoxUp.y = position.y - 23;
    hitBoxRight.x = position.x + 8;
    hitBoxRight.y = position.y;
    hitBoxDown.x = position.x - 8;
    hitBoxDown.y = position.y + 20;
    hitBoxLeft.x = position.x - 8;
    hitBoxLeft.y = position.y;
  }
  boolean checkPortals() {
    boolean playerTouchedPortal = pg.checkPortals(hitBox);
    return playerTouchedPortal;
  }
  void transportPlayer() {
    // transport player
    position.x = pg.pOut.x;
    position.y = pg.pOut.y;
  }
  boolean checkExit(Exit e) {
    if ((hitBoxUp.x >= e.x && hitBoxUp.x <= e.x + e.w) && (hitBoxUp.y >= e.y && hitBoxUp.y <= e.y + e.h )) { // check player top
      saveGame = true;
      return true;
    }
    if ((hitBoxRight.x >= e.x && hitBoxRight.x <= e.x + e.w) && (hitBoxRight.y >= e.y && hitBoxRight.y <= e.y + e.h )) { // check player right
      saveGame = true;
      return true;
    }
    if ((hitBoxDown.x >= e.x && hitBoxDown.x <= e.x + e.w) && (hitBoxDown.y >= e.y && hitBoxDown.y <= e.y + e.h )) { // check player down
      saveGame = true;
      return true;
    }
    if ((hitBoxLeft.x >= e.x && hitBoxLeft.x <= e.x + e.w) && (hitBoxLeft.y >= e.y && hitBoxLeft.y <= e.y + e.h )) { // check player top
      saveGame = true;
      return true;
    }
    return false;
  }
}

/* jump key combos */

//} else if (keys[0] && !(keys[1]) && keys[2]) { // left, jump pressed
    //  currAnimation = animations.run;
    //  position.x -= 1;
    //  //applyForce(jumpForce);
    //} else if (!(keys[0]) && keys[1] && keys[2]) { // right, jump pressed
    //  currAnimation = animations.run;
    //  position.x += 1;
    //  //applyForce(jumpForce);
    //} else if (!(keys[0]) && !(keys[1]) && keys[2]) { // jump pressed
    //  currAnimation = animations.idle;
    //  //applyForce(jumpForce);
