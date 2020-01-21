class spring {
  float tension; //spring constant
  float force; //force exerted by tense, ideal spring
  float lInit; //initial length
  float lCurrent; //used to calculate displacement of spring
  float displacement;
  PVector end1, end2; //"points" spring is connected to
  int[] pIndex = new int[2]; //FOR USE IN CONSTRUCT
  
  spring(PVector one, PVector two, float constant) { //"fun" spring constructor
    end1 = one;
    end2 = two;
    lInit = dist(end1.x, end1.y, end2.x, end2.y);
    lCurrent = lInit;
    force = 0;
    displacement = 0;
    tension = constant;
  }
  
  spring(PVector one, PVector two) { //spring constructor with "default" tension
    end1 = one;
    end2 = two;
    lInit = dist(end1.x, end1.y, end2.x, end2.y);
    lCurrent = lInit;
    force = 0;
    displacement = 0;
    tension = 1.0;
  }
  
  void update(PVector e1, PVector e2) { //calculate dynamics
    end1 = e1;
    end2 = e2;
    lCurrent = dist(end1.x, end1.y, end2.x, end2.y); //move spring
    displacement = lCurrent - lInit; //how far has the spring been streched/compressed?
    force = tension * displacement; //update force that the spring exerts
  }
  
  void display() { //draw the spring
    line(end1.x, end1.y, end2.x, end2.y);
  }
}

///////////////////////////////////////////////////////////////SMALL FUNCTIONS TO ORGANIZE COMPUTATIONS

PVector calcForce(PVector e1, PVector e2, float magnitude) { //calculate force between two objects (positions represented by PVectors)
  PVector direction = PVector.sub(e2, e1);
  direction.setMag(magnitude);
  return direction;
}