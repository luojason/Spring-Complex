void keyPressed() { //pressing the spacebar allows you to toggle between placing down nodes and screwing around with them
  if(key == 32) {
    initializing = !initializing;
  }
  if(key == 122 && initializing) { //press z to set an "anchor"
    c.addAnchor(mouseX, mouseY);
  }
  if(key == 120) {
    gravity = !gravity; //press x to initiate gravity
  }
}

void mouseReleased() {
  if(initializing) {
    boolean testb = false;
    int testi = 0;
    for(int i = 0; i < c.particles.length; i ++) {
      particle p = c.particles[i];
      float dist = dist(mouseX, mouseY, p.position.x, p.position.y);
      if(dist < 10) {
        testb = true;
        testi = i;
        i = c.particles.length;
      }
    }
    if(!testb) {
      c.addPoint(mouseX, mouseY);
    } else {
      c.add_extendPoint(testi);
    }
  }
}

void mousePressed() {
  if(!initializing) {
    for(int i = 0; i < c.particles.length; i ++) {
      particle p = c.particles[i];
      float dist = dist(mouseX, mouseY, p.position.x, p.position.y);
      if(dist < 10) {
        lock = i;
        return;
      }
    }
  }
}

void mouseDragged() {
  if(!initializing && !c.particles[lock].isAnchor) {
    c.particles[lock].position = new PVector(mouseX, mouseY);
  }
}