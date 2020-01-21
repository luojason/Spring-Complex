class construct {
  particle[] particles = new particle[0]; //particle system
  spring[] springs = new spring[0]; //spring system
  int Pcounter = 0;
  int Scounter = 0;
  
  construct() { //empty, simply assign memory for object
  }
  
  void addPoint(float x, float y) {
    float m = random(0.05, 1);
    particle p = new particle(x, y, m);
    particles = (particle[])append(particles, p);
    if(Pcounter > 0) {
      addSpring(Pcounter - 1, Pcounter);
    }
    Pcounter ++;
  }
  
  void addAnchor(float x, float y) {
    particle p = new particle(x, y);
    particles = (particle[])append(particles, p);
    if(Pcounter > 0) {
      addSpring(Pcounter - 1, Pcounter);
    }
    Pcounter ++;
  }
  
  void add_extendPoint(int index) { //functionality of connecting springs to already established dots
    if(Pcounter > 0 && !(index == Pcounter - 1)) {
      addSpring(Pcounter - 1, index);
    }
  }
  
  void addSpring(int i1, int i2) {
    PVector e1 = particles[i1].position;
    PVector e2 = particles[i2].position;
    float t = random(0.05, 2);
    spring s = new spring(e1, e2, t); //create new spring to connect to points
    s.pIndex[0] = i1; //store indexes of particles spring is connected to for later use
    s.pIndex[1] = i2;
    springs = (spring[])append(springs, s);
    particles[i1].springIndex = append(particles[i1].springIndex, Scounter); //store indexes of springs particles are connected to for later use
    particles[i2].springIndex = append(particles[i2].springIndex, Scounter);
    Scounter ++;
  }
  
  void massUpdate() { //update EVERYTHING
    for(spring s : springs) { //first calculate springs + forces they will be exerting
      int index1 = s.pIndex[0]; //retrieve indexes
      int index2 = s.pIndex[1];
      PVector update_e1 = particles[index1].position;
      PVector update_e2 = particles[index2].position;
      s.update(update_e1, update_e2);
    }
    for(particle p : particles) { //next calculate change in position of particles
      if(!p.isAnchor) {
        PVector sumForce = new PVector(0, 0);
        for(int i : p.springIndex) { //cumulative forces of all springs particle is attached to
          spring getForce = springs[i];
          if(getForce.end1 == p.position) { //determine direction spring is pulling/pushing in
            PVector _force = calcForce(getForce.end1, getForce.end2, getForce.force);
            sumForce.add(_force);
          } else {
            PVector _force = calcForce(getForce.end2, getForce.end1, getForce.force);
            sumForce.add(_force);
          }
        }
        if(gravity && p.position.y < height) {
          sumForce.add(new PVector(0, 10));
        }
        p.update(sumForce);
      }
    }
  }
  
  void massDisplay() { //display EVERYTHING
    for(particle p : particles) {
      p.display();
    }
    for(spring s : springs) {
      s.display();
    }
  }
}