////int MAX_GLOVES = 1;
Glove glove;
PImage gloveImage;

void setup()
{
  size(800, 800);
  background(20); 
  loadGloves();
  gloveImage = loadImage("g.png");
}

void draw()
{
  background(265);
  glove.run();
}

void loadGloves()
{
  glove = new Glove(new PVector((int) random(width), (int) random(height)));
}

void mouseMoved() {
  PVector  mouse = new PVector(mouseX, mouseY);
  glove.mouseMovedHandler(mouse);
}

void keyPressed() {
  glove.setDirection(keyCode);
}

//PImage img;{
//img = loadImage("baseballglove.htm");
//image(img, 0, 0);
//}



