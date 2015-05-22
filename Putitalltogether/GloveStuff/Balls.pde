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

