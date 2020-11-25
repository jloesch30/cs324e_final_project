class Timer {
  
  int startTime = 0;
  int stopTime = 0;
  int timeElapsed = 0;
  boolean running = false;
  boolean resume = false;
  
  
  void start(){
    startTime = millis();
    running = true; 
  }
  
  void resume(){
    //running = true;
    resume = true;
    startTime = millis();
  }
  
  void stop(){
    stopTime = millis();
    timeElapsed += stopTime - startTime;
    running = false;
    resume = false;
  }
  
  int getElapsedTime(){
    int elapsed;
    if (running){
      elapsed = (millis() - startTime);
    } else if (resume){
      elapsed = ((millis() - startTime) + timeElapsed);
    } else {
      elapsed = timeElapsed;
    }
    return elapsed;
  }
  
  int second(){
    return (getElapsedTime() / 1000) % 60;
  }
  
  int minute(){
    return (getElapsedTime() / (1000*60)) % 60;
  }
}
