float x, y; // Pendulum anchor point
float px, py; // Pendulum bob position
float vx, vy; // Velocity of the anchor
float ax, ay; // Acceleration of the anchor
float angle; // Current angle of pendulum
float angleVelocity; // Angular velocity
float angleAcceleration; // Angular acceleration
float pendulumLength = 100; // Length of pendulum
float gravity = 0.2; // Gravity affecting pendulum
float maxSpeed = 10; // Max speed of anchor

void setup() {
  size(800, 600);
  x = width / 2;
  y = height / 2;
  angle = PI / 2; // Initial pendulum angle
  angleVelocity = 0;
  vx = random(-2, 2);
  vy = random(-2, 2);
}

void draw() {
  background(30, 40, 50);

  // Update anchor position
  x += vx;
  y += vy;

  // Bounce anchor off edges
  if (x > width || x < 0) vx *= -1;
  if (y > height || y < 0) vy *= -1;

  // Pendulum physics
  angleAcceleration = (-gravity / pendulumLength) * sin(angle);
  angleVelocity += angleAcceleration;
  angleVelocity *= 0.99; // Damping
  angle += angleVelocity;

  // Calculate pendulum bob position
  px = x + pendulumLength * sin(angle);
  py = y + pendulumLength * cos(angle);

  // Draw pendulum anchor
  fill(200, 200, 255);
  noStroke();
  ellipse(x, y, 20, 20);

  // Draw pendulum rod
  stroke(255);
  strokeWeight(2);
  line(x, y, px, py);

  // Draw pendulum bob
  noStroke();
  fill(255, 100, 100);
  ellipse(px, py, 30, 30);

  // Apply movement acceleration
  ax = random(-0.1, 0.1);
  ay = random(-0.1, 0.1);
  vx += ax;
  vy += ay;

  // Limit velocity
  vx = constrain(vx, -maxSpeed, maxSpeed);
  vy = constrain(vy, -maxSpeed, maxSpeed);
}
