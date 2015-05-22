class Glove {

  PVector loc, vel, acc;
  int rad = (int)random(30)+10;
  color c;
  float angle;
  Glove(PVector l)
  {
    acc = new PVector(0,0);
    loc = l;
    vel = new PVector(0,0);
    c = color((int)random(256), (int)random(256), (int)random(256));
    angle = 0;
  }

  void run()
  {
    display();
    update();
    checkEdges();
  }

  void display()
  {
    angle += 0.05;
    fill(c);
    pushMatrix();
    ellipse(loc.x, loc.y, rad, rad);
    translate(loc.x, loc.y);
    imageMode(CENTER);
    scale(.25);
    rotate(angle);
    image(gloveImage, 0, 0);
    popMatrix();
  }

  void update()
  {
    vel.add(acc);
    vel.limit(2);
    loc.add(vel);
  }

  void checkEdges()
  {
    if (loc.x > width  || loc.x < 0 ) vel.x *= -1; //speedX*(-1);
    if (loc.y > height || loc.y < 0 ) vel.y *= -1;
    ; //speedY*(-1);
  }

  void setDirection(int direction) {

    if (direction == UP) {
      print("Hit up");
    } 
    else if (direction == DOWN) {
      print("Hit down");
    }
  }
  void mouseMovedHandler(PVector m) {
    acc = PVector.sub(m, loc);
    acc.normalize();
    acc.mult(0.5);
  }
}




