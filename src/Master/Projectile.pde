class Projectile {
  float fireVelocity;
  float angle;
  PVector position;
  PVector velocity;
  PVector direction;
  PVector startPos;
  
  // bounds for particle delete
  float rangeDirXLeft;
  float rangeDirXRight;
  float rangeDirYUp;
  float rangeDirYDown;
  
  Projectile(PVector playerPos, PVector mousePos) {
    startPos = playerPos;
    position = playerPos;
    direction = mousePos;
    fireVelocity = 4;
    
    // bounds
    rangeDirXLeft = direction.x - 3;
    rangeDirXRight = direction.x + 3;
    rangeDirYUp = direction.y - 3;
    rangeDirYDown = direction.y + 3;
    
  }
  void move() {
    position.x = lerp(position.x, direction.x, 0.09);
    position.y = lerp(position.y, direction.y, 0.09);
  }
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    fill(255);
    ellipse(0, 0, 10, 10);
    popMatrix();
    move();
  }

  // returns true if the projectile is at it's final destination
  boolean complete() {
    if ((position.x >= rangeDirXLeft && position.x <= rangeDirXRight) && (position.y <= rangeDirYDown && position.y >= rangeDirYUp)) {
      return true;
    }
    return false;
  }
}
