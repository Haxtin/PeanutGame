# PeanutGame
Peanut Game
Flock flock1, flock2;
int MAX_BALLS = 500;
PImage img1, img2;

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup()
{
  size(800, 800); 
  img1 = loadImage("Peanut_Enemy.png"); 
  img2 = loadImage("bb.png");  
  flock1 = new Flock();
  flock2 = new Flock();
  for (int i = 0; i < 20; i++) {
    flock1.addBoid(new Boid(200, 200, img1));
    flock2.addBoid(new Boid(600, 600, img2));
  }
  
  
}

void draw()
{  
  background(200, 0, 200);
  
  flock1.run();
  flock2.run();
}

void loadBalls()
{
  for (int i = 0;i < MAX_BALLS; i++)
  {
    balls.add(new Ball ((int) random (width), (int) random (width)));
  }
}




///NExt PagE
class Ball
{
  int locX, locY, speedX, speedY;
  int run;
  color c;

  Ball(int x, int y)
  {
    locX = x;
    locY = y;
    speedX = (int) random(-5, 5); 
    speedY = (int) random(-5, 5); 
    c = color ((int) random (256), (int) random (256), (int) random (256));
    img1 = loadImage("Peanut_Enemy.png");
    img2 = loadImage("bb.png");
  }
  void display()
  {
    pushMatrix();
    translate(locX, locY);
    scale(2);
    fill(c);
    image(img1, locX, locY);
    popMatrix();
  }
  void update()
  {
    locX = locX + speedX;
    locY = locY + speedY;
  }

  void checkEdges()
  {
    if ( locX > width || locX < 0) speedX*= -1;
    if ( locY > height || locY < 0) speedY*= -1;
  }

  void run()
  {
    display();
    update();
    checkEdges();
  }
}






///Next PaGe of FlOcK



class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

    Flock() {

    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {

    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
}




// The Boid class

class Boid {

  PVector loc;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  PImage img;

    Boid(float x, float y,PImage i) {
    img = i;
    acceleration = new PVector(0, 0);

    // This is a new PVector method not yet implemented in JS
    // velocity = PVector.random2D();

    // Leaving the code temporarily this way so that this example runs in JS
    float angle = random(TWO_PI);
    velocity = new PVector(cos(angle), sin(angle));

    loc = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.03;
  }

  void run(ArrayList<Boid> boids) {
    //println("Boid Run");
    flock(boids);
    update();
    borders();
    display();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update loc
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    loc.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    println("Boid update = " );
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, loc);  // A vector pointing from the loc to the target
    // Scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);

    // Above two lines of code below could be condensed with new PVector setMag() method
    // Not using this method until Processing.js catches up
    // desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up

    fill(200, 100);
    stroke(255);
    pushMatrix();
    translate(loc.x, loc.y);
    scale(.2);
       image(img, loc.x, loc.y);
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(loc, other.loc);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(loc, other.loc);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // steer.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(loc, other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      // First two lines of code below could be condensed with new PVector setMag() method
      // Not using this method until Processing.js catches up
      // sum.setMag(maxspeed);

      // Implement Reynolds: Steering = Desired - Velocity
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average loc (i.e. center) of all nearby boids, calculate steering vector towards that loc
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all locs
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(loc, other.loc);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.loc); // Add loc
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the loc
    } 
    else {
      return new PVector(0, 0);
    }
  }
}
