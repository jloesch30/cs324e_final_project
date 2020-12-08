class GameBoard {
	// player, protal gun, and portals
	Player player;
	PortalGun pg;

  //Portals port;
	float playerPosX;
	float playerPosY;
	
	// obstical holder
	ArrayList<Obstacle> objs;

  // exit
  Exit e;
	
  // game board variables
	boolean won;
	boolean initialGameStart;
  boolean pause;
	int lives;

	// GUI
	GUI gui;

  //game timer
	Timer t;
  boolean timerRunning;
  boolean looseGame;
  
  //REMOVE ME
  int maxTimeAllowed;

	// constructor
	GameBoard() {
		playerPosX = 100;
		playerPosY = 300;
		player = new Player(playerPosX, playerPosY);
		pg = new PortalGun();
		objs = new ArrayList<Obstacle>();
		gui = new GUI();
		won = false;
    pause = false;
		initialGameStart = true;
    testObjs();
    
    // timer
    t = new Timer();
    timerRunning = false;
    maxTimeAllowed = 5; // remove me
    looseGame = false;
	}
	
	// display board
	void display() {
    // timer
    if (timerRunning) {
      int timeElapsed = t.second();
      if (timeElapsed >= maxTimeAllowed) {
        looseGame = true;
      }
    }
  
    if (initialGameStart) {
      gui.mainMenu();
    } else if (pause) {
      // TODO: make pause screen and freeze items in the back (or not). For now putting main menu
      gui.pauseMenu();
    } else {
      if ((!(looseGame)) && (!(player.wonGame))) { // game can end either by a defeat or getting to the exit
        player.display(objs, e);
        for (Obstacle o : objs) {
          o.display(); // display the objects
          e.display(); // display the exit
        }
      } else { // loosegame == true or player.wonGame == true
        if (looseGame) {
          gui.defeatDisplay();
        } else if (player.wonGame) {
          t.stop(); // stop the time
          gui.victoryDisplay();
        } else {
          println("an error has occured");
          gui.mainMenu();
        }
      }
		}
  }
	
	void keyPressed(char k) {
		if (k == 'a' || k == 'd' || k == ' ') { // character movement pressed
			player.activateActionState(k);
		} else if (k == '1') { 
			player.pg.changeState();
		}
	}
	void keyReleased(char k) {
    // movement keys
		if (k == 'a' || k == 'd' || k == ' ') { // character movement released
			player.deactivateActionState(k);

    // GUI keys
		} else if (key == ENTER && initialGameStart == true) { // start game
        initialGameStart = false;
        t.start(); // start timer
        timerRunning = true;
    } else if (key == BACKSPACE && initialGameStart == false) { // Pause game
        pause = !(pause);
        if (pause == true) {
          t.stop();
        } else {
          t.resume();
        }
    }
	}
  void loadMap() {
    
  }
	void mousePressed() {
		player.pg.spawnProjectile(player.position);
	}
  void testObjs() {
    Obstacle obj1 = new Obstacle(200, height-50, 20, 50);
    Obstacle obj2 = new Obstacle(40, 30, 20, 50);
		Obstacle obj3 = new Obstacle(40, 70, 70, 20);
		Obstacle obj4 = new Obstacle(400, 90, 70, 10);
		Obstacle obj5 = new Obstacle(440, 40, 30, 50);
		Obstacle obj6 = new Obstacle(75, 0, 40, 10);
    e = new Exit(420, 85, 20, 5);

		// obs
    objs.add(obj1);
    objs.add(obj2);
		objs.add(obj3);
		objs.add(obj4);
		objs.add(obj5);
		objs.add(obj6);
  }
}
