ArrayList<Leaf> leaves = new ArrayList<Leaf>();
float angleOffset = 0; // Offset for waving effect

void setup() {
  size(800, 600);
}

void draw() {
  background(220);

  // Draw the creature in the middle of the screen
  float x = width / 2;
  float y = height / 2;
  drawCreature(x, y);
  
  // Update and draw leaves
  for (int i = leaves.size() - 1; i >= 0; i--) {
    Leaf leaf = leaves.get(i);
    leaf.update();
    leaf.display();
    if (leaf.isOffScreen()) {
      leaves.remove(i); // Remove leaves when they fall off the screen
    }
  }
  
  // Increment angle offset for animation
  angleOffset += 0.05;
}

void drawCreature(float x, float y) {
  float bodySize = 150;

  // Draw fractal trees
  drawTree(x, y - 70, PI / 2, 50, 5); // Tree in the center
  drawTree(x - 40, y - 60, PI / 2, 40, 4); // Left tree
  drawTree(x + 40, y - 60, PI / 2, 40, 4); // Right tree
  // Draw body
  fill(150, 200, 250);
  noStroke();
  ellipse(x, y, bodySize, bodySize);

  // Draw eyes
  float eyeOffsetX = 30;
  float eyeOffsetY = -20;
  float eyeSize = 20;
  fill(255);
  ellipse(x - eyeOffsetX, y + eyeOffsetY, eyeSize, eyeSize);
  ellipse(x + eyeOffsetX, y + eyeOffsetY, eyeSize, eyeSize);

  // Pupils
  fill(0);
  ellipse(x - eyeOffsetX, y + eyeOffsetY, eyeSize / 2, eyeSize / 2);
  ellipse(x + eyeOffsetX, y + eyeOffsetY, eyeSize / 2, eyeSize / 2);

  // Draw mouth
  fill(255, 100, 100);
  arc(x, y + 30, 80, 40, 0, PI, CHORD);
}

void drawTree(float x, float y, float angle, float length, int depth) {
  if (depth == 0) return;

  // Calculate waving effect
  float wave = sin(angleOffset + x * 0.05) * QUARTER_PI;

  float x2 = x + cos(angle + wave) * length;
  float y2 = y - sin(angle + wave) * length;

  // Draw the branch
  stroke(0, 100, 0);
  strokeWeight(depth);
  line(x, y, x2, y2);

  // Randomly decide if a leaf should fall from this branch
  if (random(1) < 0.05) { // 5% chance for a leaf to fall per frame
    leaves.add(new Leaf(x2, y2));
  }

  // Recursive calls for smaller branches
  drawTree(x2, y2, angle - QUARTER_PI, length * 0.7, depth - 1);
  drawTree(x2, y2, angle + QUARTER_PI, length * 0.7, depth - 1);
  drawTree(x2, y2, angle, length * 0.7, depth - 1); // New branch in the middle
}

class Leaf {
  float x, y; // Position of the leaf
  float speedX, speedY; // Speed of the leaf
  float size; // Size of the leaf

  Leaf(float startX, float startY) {
    x = startX;
    y = startY;
    speedX = random(-1, 1); // Slight horizontal speed
    speedY = random(1, 3); // Vertical speed for falling
    size = random(5, 10); // Random leaf size
  }

  void update() {
    x += speedX; // Apply horizontal movement
    y += speedY; // Apply vertical movement
    speedY += 0.05; // Simulate gravity (slower downward motion over time)
  }

  void display() {
    fill(34, 139, 34); // Leaf color (green)
    noStroke();
    ellipse(x, y, size, size); // Draw the leaf as a small circle
  }

  boolean isOffScreen() {
    return y > height || x < 0 || x > width; // Check if the leaf is off-screen
  }
}
