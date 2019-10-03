
class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  float x;
  float y;

  // Constructor
  Box(float x_, float y_) {
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

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

  
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    //rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(a);
    noFill();
    noStroke();
    ellipse(0,0,w,h);
    //imageMode(CENTER);
    image(Elevenfinal,0-20,0-25,w,h);
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
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.2;

    body.createFixture(fd);
    //body.setMassFromShapes();

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(0,0));
    body.setAngularVelocity(0);
  }

}
