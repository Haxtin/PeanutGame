class Button {

  // +++++++++++++++++++++++++++++++++++++++++      Properties
  PVector loc;
  int h, w;
  String txt;
  color c = color(11, 16, 87);
  float fadeValue = 250;

  //  +++++++++++++++++++++++++++++++++++++++++++   Constructor
  Button(PVector loc, int w, int h) {
    this.loc=loc;
    this.w=w;
    this.h=h;
    txt="Sample Text";
  }


  Button(PVector loc, int w, int h, String txt) {
    this.loc=loc;
    this.w=w;
    this.h=h;
    this.txt=txt;
  }

  //  ++++++++++++++++++++++++++++++++++++++++++++   Methods
  void run() {
    display();
  }


  void display() {
    //display rectangle

    if (fadeButton) {
      fadeValue -= 10;
    }
    if (fadeValue > 0) {
      fill(color(11, 16, 87, fadeValue));
      stroke(2);
      strokeWeight(3);
      rect(loc.x, loc.y, w, h, 20);
      //display test
      fill(255);
      textSize(90);
      text(txt, loc.x+30, loc.y+h/2);
    }
  }

  boolean hitTest(PVector m) {
    if (m.x > loc.x && m.x < loc.x + w && m.y > loc.y && m.y < loc.y + h ) {

      return true;
    } 
    else {
      return false;
    }
  }
}

