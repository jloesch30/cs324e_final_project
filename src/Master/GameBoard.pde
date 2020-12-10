class GameBoard {
  // map reader and writer
  MapReader r;
  MapWriter output;
  
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
  int rawMapNum;
  int realMapNum;
  int numberOfMaps = 2;
  boolean readNextMap;
  boolean levelsCompleted;

	GameBoard() {
		pg = new PortalGun();
		gui = new GUI();
    r = new MapReader();
    output = new MapWriter();
    pause = false;
		initialGameStart = true;
    looseGame = false;
    rawMapNum = 0;
    readNextMap = false;
    levelsCompleted = false;
    objs = new ArrayList<Obstacle>();
	}
	
	// display board
	void display() {
    if (levelsCompleted) {
      gui.victoryDisplay();
      println("you completed the game!");
    }
    
    // read in a map if needed
    if (readNextMap) {
      loadMap();
      t.start();
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
      // note: timer is handled in the button press
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
        } else if (player.wonGame && player.saveGame) {
          t.stop(); // stop the time
          output.saveTime(t.second(), realMapNum); // save the time here
          player.saveGame = false;
          gui.victoryDisplay();
        } else if (player.wonGame && player.saveGame == false) {
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
        timerRunning = true; // we may remove this
        readNextMap = true;
    } else if (key == ENTER && player.wonGame == true) { // player won game and requested next level
        if ((rawMapNum + 1) >= (numberOfMaps)) {
          levelsCompleted = true;
        } else {
          rawMapNum += 1; // increase map count to load next map in JSON file
          readNextMap = true; // indicate to read next map
          player.wonGame = false; // reset player won state
          player.saveGame = true; // reset save flag for new map
        }
    } else if (key == BACKSPACE && initialGameStart == false) { // Pause game
        pause = !(pause);
        if (pause == true) {
          t.stop();
        } else {
          t.resume();
        }
    } else if (key == 'q' && levelsCompleted == true) {
      output.closeFile();
      exit();
    }
	}
  void loadMap() {
    println("raw map num is: " + rawMapNum);
    // remove objects if nessisary
    if (objs != null && objs.size() > 0) {
      objs.clear();
    }
    
    // create new timer
    t = new Timer();
    r.readMap(rawMapNum);
    realMapNum = (rawMapNum + 1);
    
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
    if (!(initialGameStart || pause || player.wonGame))  {
      player.pg.spawnProjectile(player.position);
    }	
	}
}
