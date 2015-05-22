Button b1;
boolean fadeButton = false;

void setup() {
  size(800, 800);
  b1 = new Button (new PVector(220, 150), 300, 150, " Play");
}

void draw() {
  //  If Playing game, run all game components
  if (true) {
    background(255, 200, 50);
    b1.run();
  } 
  //  If not playing game, show play again screen
  else {
    background(255, 50, 150);
  }
}


void mouseMoved() {
  // if mouse is MOVED and OVER BUTTON, change button color
  if (b1.hitTest(new PVector(mouseX, mouseY)))
    b1.c = color(24, 150, 36);

  else
    b1.c = color(8, 50, 12);
}

void mousePressed() {
  //If mouse is PRESSED  and OVER BUTTON, reset game
  if (mousePressed == true & b1.hitTest(new PVector(mouseX, mouseY)) == true) 
    b1.c = color(24, 10, 36);
    
  }


void mouseReleased() {
  //If mouse is Released  fade the buttom
  if (mousePressed == true & b1.hitTest(new PVector(mouseX, mouseY)) == true) 
    fadeButton = true;
    
  }











