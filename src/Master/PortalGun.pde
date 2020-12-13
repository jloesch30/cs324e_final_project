class PortalGun { //<>//
  // projectiles
  ArrayList<Projectile> projectiles;
  
  // in and out booleans
  boolean in;

  // protals (portal object within portal object)
  Portals pIn;
  Portals pOut;
  
  PortalGun() {
    // projectiles
    projectiles = new ArrayList<Projectile>();
    
    // state of the portals
    in = true;
  }
  void display(ArrayList<Obstacle> objs) {
    // projectile handling and portal handling
    if (!(projectiles.size() < 1)) {
      fireProjectiles(objs);
    }
    if (pIn != null) {
      pIn.display();
    }
    if (pOut != null) {
      pOut.display();
    }
  }
  void fireProjectiles(ArrayList<Obstacle> objs) {
    ArrayList<Projectile> pCopy = new ArrayList<Projectile>(projectiles);
    for (Projectile p : pCopy) {
      p.display();
      boolean hitWall = hitWall(p, objs);
      boolean destroy = p.complete();
      if (destroy || hitWall) {
        projectiles.remove(p);
        if (hitWall) {
          // spawn a portal where the projectile hit object, check where the projectile hit object??
          if (in) {
            pIn = new Portals(p.position.x, p.position.y, true);
          } else {
            pOut = new Portals(p.position.x, p.position.y, false);
          }
        }
      }
    }
  }
  void spawnProjectile(PVector playerPos) {
    PVector startPos = new PVector(playerPos.x, playerPos.y);
    Projectile p = new Projectile(startPos, new PVector(mouseX, mouseY));
    projectiles.add(p);
  }
  
  // change the state of in and out portals
  void changeState() {
    in = !(in);
    }
  boolean hitWall(Projectile p, ArrayList<Obstacle> objs) {
    // TODO
    for (Obstacle o : objs) {
      boolean h = o.checkProjectile(p.position); // true if wall hit 
      if (h) {
        return true;
      }
    }
    return false;
  }
  void displayGun() {
    pushMatrix();
    rect(0+1, 0, 20, 10);
    popMatrix();
  }
  boolean checkPortals(PVector[][] hitBox) {
    // check if the player has entered the portal
    if (pIn == null || pOut == null) {
      return false;
    } else {
      // see if the player is in proximity to the (in) portal, if so, return true
      boolean playerInsideInPortal = pIn.inside(hitBox);
      return playerInsideInPortal;
    }
  }
}
