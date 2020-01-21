class particle { //points springs are connected together
  PVector position;
  PVector velocity;
  float massRatio; // value between 0 < x <= 1
  float massConstant = 100; //maximum range of mass
  float radiusConstant = 2.5; //size of particle
  int[] springIndex = new int[0]; //FOR USE IN CONSTRUCT
  boolean isAnchor; //does the weight have a fixed position (used in construct processes)
  
  particle(float x, float y, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    massRatio = m;
    isAnchor = false;
  }
  
  particle(float x, float y) { //constructing anchor points
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    massRatio = 1;
    isAnchor = true;
  }
  
  void update(PVector force) {
    float mass = massRatio * massConstant;
    PVector acceleration = PVector.div(force, mass);
    velocity.add(acceleration);
    position.add(velocity); //spring force action
    if(!(0 <= position.x && position.x <= width)) { //bouncing action
      velocity.set(velocity.x * -1, velocity.y);
      velocity.setMag(constrain(velocity.mag(), -10, 10));
      position.x = constrain(position.x, 0, width);
    }
    if(!(0 <= position.y && position.y <= height)) {
      velocity.set(velocity.x, velocity.y * -1);
      velocity.setMag(constrain(velocity.mag(), -10, 10));
      position.y = constrain(position.y, 0, height);
    }
    velocity.mult(friction);
  }
  
  void display() {
    fill((1 - massRatio) * 255);
    ellipse(position.x, position.y, radiusConstant, radiusConstant);
  }
}