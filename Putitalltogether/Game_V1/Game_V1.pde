Flock flock1, flock2;
Button b1;
boolean fadeButton = false;
int MAX_BALLS = 500;
PImage img1, img2;

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup()
{
  size(800, 800); 
  b1 = new Button (new PVector(220, 150), 300, 150, " Play");
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
  if (true) {
    background(0, 0, 0);  // Background color
    b1.run();
    flock1.run();
    flock2.run();
  } 
  //  If not playing game, show play again screen
  else {
    background(255, 50, 150);
  }
}

void loadBalls()
{
  for (int i = 0;i < MAX_BALLS; i++)
  {
    balls.add(new Ball ((int) random (width), (int) random (width)));
  }
}
void mousePressed() {
  //If mouse is PRESSED  and OVER BUTTON, reset game
  if (mousePressed == true & b1.hitTest(new PVector(mouseX, mouseY)) == true) 
    fadeButton = true;
}



