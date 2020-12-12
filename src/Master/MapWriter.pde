class MapWriter {
  
  PrintWriter output;
  
  MapWriter() {
    output = createWriter("data/score.txt");
  }
  void saveTime(int seconds, int level) {
    output.println(level + " " + seconds);
  }
  void closeFile() {
    output.flush();
    output.close();
  }
}
