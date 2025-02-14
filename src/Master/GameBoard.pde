//<>// //<>//
class GameBoard {
  // map reader and writer
  MapReader r;
  MapWriter output;


  // player, protal gun, and portals
  Player player; // read in
  PortalGun pg;
  boolean pgState;


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
  boolean restart;
  boolean showScore;
  boolean exitSketch = false;
  int timeElapsed = 0;

  GameBoard() {
    pg = new PortalGun();
    pgState = true;
    gui = new GUI();
    r = new MapReader();
    output = new MapWriter();
    pause = false;
    initialGameStart = true;
    looseGame = false;
    rawMapNum = 0;
    readNextMap = false;
    levelsCompleted = false;
    restart = false;
    showScore = false;
    objs = new ArrayList<Obstacle>();
  }

  // display board
  void display() {

    if (gui.mPress == true)
    {
      gui.updateColor(200, 200, 200);
    } else {
      gui.updateColor(255, 255, 255);
    }

    if (levelsCompleted && (!(showScore))) { // all levels completed
      gui.victoryDisplay();
      output.closeFile(); // close writer
    } else if (levelsCompleted && showScore) {
      gui.highScoreDisplay();
    } else { // player still playing
      // read in a map if needed
      if (readNextMap) {
        loadMap();
        t.start();
      }

      //timer
      if (timerRunning) {
        timeElapsed = t.second();
        if (timeElapsed >= maxTimeAllowed) {
          looseGame = true;
        }
      }

      if (initialGameStart) {
        gui.mainMenu();
        gui.muteButton();
      } else if (pause) {
        // note: timer is handled in the button press
        gui.pauseMenu();
      } else {

        gui.pauseButton();
        gui.levelDisplay(realMapNum);
        if ((!(looseGame)) && (!(player.wonLevel))) { // game can end either by a defeat or getting to the exit
          gui.pauseButton();
          gui.levelDisplay(realMapNum);
          gui.timeDisplay(maxTimeAllowed - timeElapsed);
          player.display(objs, e);
          showPortalGunState();
          for (Obstacle o : objs) {
            o.display(); // display the objects
            e.display(); // display the exit
          }
        } else { // loosegame == true or player.wonLevel == true
          if (looseGame) {
            t.stop();
            gui.defeatDisplay();
            gui.exitButton();
            gui.muteButton();
          } else if (player.wonLevel && player.saveGame) {
            t.stop(); // stop the time
            output.saveTime(t.second(), realMapNum); // save the time here
            player.saveGame = false;
            gui.lvlPassed();
          } else if (player.wonLevel && player.saveGame == false && levelsCompleted == false) { // player reached the exit and game has been saved
            gui.lvlPassed();
          } else {
            println("an error has occured");
            gui.mainMenu();
          }
        }
      }

      boolean hovering = gui.clickHover(mouseX, mouseY);
      if (hovering) {
        gui.hover = true;
        gui.updateColor(0, 10, 200);
      } else {
        gui.updateColor(255, 255, 255);
        gui.hover = false;
      }
    }
  }


  void draw() {
    line(mouseX, mouseY, 50, 50);
  }

  void loadMap() {
    //remove objects if nessisary
    if (objs != null && objs.size() > 0) {
      objs.clear();
    }

    //create new timer
    t = new Timer();
    r.readMap(rawMapNum);
    realMapNum = (rawMapNum + 1);

    //load player data
    maxTimeAllowed = r.maxTime;
    playerPosX = r.player_spawn.getInt("x");
    playerPosY = r.player_spawn.getInt("y");
    player = new Player(playerPosX, playerPosY);

    //loading obstacles
    for (int i = 0; i < r.objs.size(); i++) {
      JSONObject obstacle = r.objs.getJSONObject(i);
      JSONObject o = obstacle.getJSONObject("obstacle_" + nf(i + 1, 0));
      int objX = o.getInt("x");
      int objY = o.getInt("y");
      int objW = o.getInt("w"); 
      int objH = o.getInt("h");
      Obstacle ob = new Obstacle(objX, objY, objW, objH);
      objs.add(ob);
    }
    //load exit
    int exitX = r.exit.getInt("x");
    int exitY = r.exit.getInt("y");
    int exitW = r.exit.getInt("w");
    int exitH = r.exit.getInt("h");
    e = new Exit(exitX, exitY, exitW, exitH);

    //change game state
    readNextMap = false;
  }
  void restartGame() {
    restart = true;
  }
  void pauseGame() {
    pause = !(pause);
    timerRunning = !(timerRunning);
    if (pause == true) {
      t.stop();
    } else {
      t.resume();
    }
  }
  void showPortalGunState() {
    textSize(15);
    textAlign(CORNER);
    if (pgState == true) {
      text("Portal gun state: IN", 10, 30);
    } else if (pgState == false) {
      text("Portal gun state: OUT", 10, 30);
    }
  }
  void keyPressed(char k) {
    if ((k == 'a' || k == 'd' || k == ' ') && (initialGameStart == false)) { // character movement pressed
      player.activateActionState(k);
    } else if (k == '1') {  //<>//
      player.pg.changeState();
      pgState = !(pgState);
    } else if (k == 'x') {
      exitSketch = true;
    }
  }
  void keyReleased(char k) {
    //movement keys
    if ((k == 'a' || k == 'd' || k == ' ') && (initialGameStart == false)) { // character movement released
      player.deactivateActionState(k);
      //<>//
      //  GUI keys //<>//
    } else if (key == ENTER && initialGameStart == true) { // start game //<>//
      initialGameStart = false; //<>//
      timerRunning = true; // we may remove this
      readNextMap = true;
    } else if (key == ENTER && player.wonLevel == true) { // player won game and requested next level
      if ((rawMapNum + 1) >= (numberOfMaps)) {
        println("completed levels");
        levelsCompleted = true;
      } else {
        rawMapNum += 1; // increase map count to load next map in JSON file
        readNextMap = true; // indicate to read next map
        player.wonLevel = false; // reset player won state //<>//
        player.saveGame = true; // reset save flag for new map //<>//
      }
    } else if (key == BACKSPACE && initialGameStart == false && player.wonLevel == false) { // Pause game
      pauseGame();
    } else if (key == 'q' && levelsCompleted == true) { // need to check if the player is on the victory screen or complted a level
      showScore = true;
    } else if (key == 'r' && (looseGame == true || levelsCompleted == true || pause == true)) { // either player lost the game or completed all levels
      restartGame();
    }
  }
  void mousePressed() {
    if (!(initialGameStart || pause || player.wonLevel || gui.hover)) {
      player.pg.spawnProjectile(player.position);
    } 
    if (gui.clickHover(mouseX, mouseY)) {
      gui.mPress = true;
      gui.hover = false;
      if (initialGameStart == false && player.wonLevel == false) {
        pauseGame(); // pause the game
      } else if (gui.hoverExit(mouseX, mouseY)) {
        gui.mPress = true;
        gui.hover = false;
        exit();
      }
    }
  }
}
