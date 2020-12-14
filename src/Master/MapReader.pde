class MapReader {
  JSONArray json;
  int currMap; // map num
  int maxTime;
  JSONArray objs; // object locations
  JSONObject player_spawn; // player spawn info
  JSONObject exit;
  
  MapReader () {
    json = loadJSONArray("maps.json");
  }
  void readMap(int mapNum) {
    JSONObject map = json.getJSONObject(mapNum);
    currMap = map.getInt("map");
    maxTime = map.getInt("max_time");
    player_spawn = map.getJSONObject("player_spawn");
    objs = map.getJSONArray("obstacles");
    exit = map.getJSONObject("exit");
    printMapInfo();
  }
  void printMapInfo() {
    println("currMap:" + currMap);
    println("player_spawn:" + player_spawn);
    println("objs:" + objs);
    println("exit:" + exit);
  }
}
