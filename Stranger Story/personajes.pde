class Mal {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  float x;
  float y;
  boolean delete = false;


  // Constructor
  Mal(float x_, float y_) {
    this.x = x_;
    this.y = y_;
    w = 50;
    h = 50;
    // Add the box to the box2d world
    makeBody(new Vec2(x,y),w,h);
    body.setUserData (this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  
  
  void delete() {
    delete = true;
  }


boolean done() {
    // Let's find the screen position of the particle
    //Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (delete==true) {
      killBody();
      return true;
    }
    return false;
  }

  
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    //rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    noFill();
    noStroke();
    ellipse(0,0,w,h);
    //imageMode(CENTER);
    image(guardia,0-25,0-25,w,h);
    popMatrix();
    
  
  }


  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 0.5;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixture(fd);
    //body.setMassFromShapes();

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(5,5));
    body.setAngularVelocity(0);
  }

}
