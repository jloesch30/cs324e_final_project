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
	void display() {
		// projectile handling
		if (!(projectiles.size() < 1)) {
			fireProjectiles();
		}
	}
	void fireProjectiles() {
		ArrayList<Projectile> pCopy = new ArrayList<Projectile>(projectiles);
		for (Projectile p : pCopy) {
			p.display();
			boolean destroy = p.complete();
			//println("destroy is: " + destroy);
			if (destroy) {
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
	}
