class GameBoard {
	// player, protal gun, and portals
	Player player;
	PortalGun pg;
  Portals port;
	float playerPosX;
	float playerPosY;
	
	// obstical holder
	ArrayList<Obstacle> objs;
	
  // game board variables
	boolean won;
	int lives;
	
	// constructor
	GameBoard() {
		playerPosX = 50;
		playerPosY = 20;
		player = new Player(playerPosX, playerPosY);
		pg = new PortalGun();
		objs = new ArrayList<Obstacle>();
		won = false;
    testObjs();
	}
	
	// display board
	void display() {
		player.show();
		pg.display();
		checkProjectiles();
    for (Obstacle o : objs) {
      o.display();
    }
	}
	void checkProjectiles() {
		if (!(pg.projectiles.size() < 1)) { // if no projectiles, do nothing
			for (Projectile projectile : pg.projectiles) { // check positions of the projectiles
        for (Obstacle obj : objs) {  // check if the projectile hit an obstacle
          boolean hit = obj.checkProjectile(projectile.position);
          if (hit && pg.in) {
            println("hit");
            port = new Portals(projectile.position.x, projectile.position.y);
          } else if (hit && !(pg.in)) {
            port.spwanOut(projectile.position);
          }
        }
			}
		}
	}

	// TODO: check if player touched a portal
	void checkPlayer() {
	}
	
	void keyPressed(char k) {
		if (k == 'a' || k == 'd' || k == ' ') { // character movement pressed
			player.activateActionState(k);
		} else if (k == '1') { 
			pg.changeState();
		}
	}
	void keyReleased(char k) {
		if (k == 'a' || k == 'd' || k == ' ') { // character movement released
			player.deactivateActionState(k);
		}
	}
	void mousePressed() {
		pg.spawnProjectile(player.position);
	}
  void testObjs() {
    Obstacle obj1 = new Obstacle(200, height-50, 20, 50);
    Obstacle obj2 = new Obstacle(40, 30, 20, 50);
		Obstacle obj3 = new Obstacle(40, 70, 70, 20);
		Obstacle obj4 = new Obstacle(400, 90, 70, 10);
		Obstacle obj5 = new Obstacle(440, 40, 30, 50);
		Obstacle obj6 = new Obstacle(75, 0, 40, 10);

		// obs
    objs.add(obj1);
    objs.add(obj2);
		objs.add(obj3);
		objs.add(obj4);
		objs.add(obj5);
		objs.add(obj6);

  }
}
