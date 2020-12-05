class PortalGun {
	// projectiles
	ArrayList<Projectile> projectiles;
	
	// in and out booleans
	boolean in;
	
	PortalGun() {
		// projectiles
		projectiles = new ArrayList<Projectile>();
		
		// state of the portals
		in = true;
	}
	void display(ArrayList<Obstacle> objs) {
		// projectile handling
		if (!(projectiles.size() < 1)) {
			fireProjectiles(objs);
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
      if (h) { //<>//
        return true;
      }
    }
    return false;
  }
}
