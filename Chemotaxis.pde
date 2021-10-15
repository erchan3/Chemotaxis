Bacteria[] bacteria;
float bias = 0.6;

void setup() {
  size(400, 400);
  bacteria = new Bacteria[100];
  for (int i = 0; i < bacteria.length; i++) {
    bacteria[i] = new Bacteria(width / 2, height / 2);
  }
}

void draw() {
  background(191);
  for (int i = 0; i < bacteria.length; i++) {
    bacteria[i].move();
    bacteria[i].show();
  }
  fill(0);
  text("bias: " + bias, 10, 10);
}

void mousePressed() {
  for (int i = 0; i < bacteria.length; i++) {
    bacteria[i].away = !bacteria[i].away;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)
      bias += 0.01;
    else if (keyCode == DOWN)
      bias -= 0.01;
  }
  bias = max(0, min(1, bias));
}

class Bacteria {
  float x, y;
  int col;
  boolean away = false;
  public Bacteria(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    col = (int)(Math.random() * 16777216)*255;
  }
  
  void move() {
    float mix = (float)Math.random() * bias;
    float dy = y - mouseY;
    float dx = mouseX - x;
    float target = PI/2 - atan(dx/dy);
    if (dy < 0)
      target += PI;
    float dir = ((float)Math.random() * (1 - mix) + 0.5 * mix) * 2 * PI - PI;
    dir = target + dir;
    if (away)
      dir += PI;
    float speed = map((float)Math.random(), 0, 1, 0, 4);
    speed = (float)Math.random() * 3 + 1;
    x += Math.cos(dir) * speed;
    y -= Math.sin(dir) * speed;
  }
  
  void show() {
    fill(col);
    ellipse(x, y, 10, 10);
  }
}
