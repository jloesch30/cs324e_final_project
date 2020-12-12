class ScoreReader {
  BufferedReader reader;
  ArrayList<String> s = new ArrayList<String>(); // array of strings
  String line;
  
  ScoreReader() {
    reader = createReader("score.txt");
  }
  
  void parseFile() {
    try {
      while ((line = reader.readLine()) != null) { //<>//
        s.add(line);
      }
      reader.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}
