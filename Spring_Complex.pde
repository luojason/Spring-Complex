construct c; //flexible structure
int lock; //stores which particle the mouse is dragging
boolean initializing;
boolean gravity;
float friction; //slowing doooowwwwnnnnnnn.... --> revamp friction mechanic in future (mu, kinetic + static calculations, normal force)

////////////////////////////////////////////////////////////////////STRUCTURE INITIALIZATION

void setup() {
  size(800, 800);
  ellipseMode(RADIUS);
  friction = .98;
  c = new construct();
  initializing = true;
  gravity = false;
}

void draw() { //"Physics" Engine
  background(255);
  c.massUpdate();
  c.massDisplay();
}