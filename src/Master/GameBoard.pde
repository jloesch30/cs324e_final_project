class GameBoard {
  // map reader
  MapReader r;
  
	// player, protal gun, and portals
	Player player; // read in
	PortalGun pg;

  //Portals port;
	float playerPosX; // read in
	float playerPosY; // read in
	
	// obstical holder
	ArrayList<Obstacle> objs; // read in objs

  // exit
  Exit e; // read in exit
	
  // game board variables
	boolean won;
	boolean initialGameStart;
  boolean pause;
	int lives; // read in

	// GUI
	GUI gui;

  //game timer
	Timer t; // read in new timer
  boolean timerRunning;
  boolean looseGame;
  
  // game state and win/loose conditions
  int maxTimeAllowed; // read in
  int mapNum;
  boolean readNextMap;

	// constructor
	GameBoard() {
		pg = new PortalGun();
		gui = new GUI();
    r = new MapReader();
		won = false;
    pause = false;
		initialGameStart = true;
    looseGame = false;
    mapNum = 0;
    readNextMap = true;
    objs = new ArrayList<Obstacle>();
    // winGame is in the player class
	}
	
	// display board
	void display() {
    // read in a map if needed
    if (readNextMap) {
      loadMap();
    }
  
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
    // remove objects if nessisary
    if (objs != null && objs.size() > 0) {
      objs.clear();
    }
    
    // create new timer
    t = new Timer();
    r.readMap(mapNum);
    
    // load player data
    maxTimeAllowed = r.maxTime;
    playerPosX = r.player_spawn.getInt("x");
    playerPosY = r.player_spawn.getInt("y");
    player = new Player(playerPosX, playerPosY);
    
    // loading obstacles
    for (int i = 0; i < r.objs.size(); i++) {
      JSONObject obstacle = r.objs.getJSONObject(i);
      JSONObject o = obstacle.getJSONObject("obstacle_"+nf(i+1, 0));
      println("object being read in is: " + o);
      int objX = o.getInt("x");
      int objY = o.getInt("y");
      int objW = o.getInt("w"); 
      int objH = o.getInt("h");
      Obstacle ob = new Obstacle(objX, objY, objW, objH);
      objs.add(ob);
    }
    // load exit
    int exitX = r.exit.getInt("x");
    int exitY = r.exit.getInt("y");
    int exitW = r.exit.getInt("w");
    int exitH = r.exit.getInt("h");
    e = new Exit(exitX, exitY, exitW, exitH);
    
    // change game state
    readNextMap = false;
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
