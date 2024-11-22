ArrayList<Emitter> emitters;

void setup() {
  size(800, 600);
  emitters = new ArrayList<>();
  emitters.add(new Emitter(width / 2, height / 2)); // Start with one emitter
}

void draw() {
  background(20, 20, 30);

  for (Emitter emitter : emitters) {
    emitter.emit();
    emitter.update();
    emitter.display();
  }

  fill(200);
  textSize(14);
  text("Click to add an emitter", 10, height - 20);
}

void mousePressed() {
  emitters.add(new Emitter(mouseX, mouseY));
}

// Emitter class
class Emitter {
  PVector position;
  ArrayList<Particle> particles;

  Emitter(float x, float y) {
    position = new PVector(x, y);
    particles = new ArrayList<>();
  }

  void emit() {
    // Add particles at the emitter's position
    particles.add(new OscillatingParticle(position.x, position.y));
    particles.add(new FadingParticle(position.x, position.y));
  }

  void update() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (!p.isAlive()) {
        particles.remove(i);
      }
    }
  }

  void display() {
    for (Particle p : particles) {
      p.display();
    }
  }
}

// Abstract base particle class
abstract class Particle {
  PVector position, velocity;
  float lifespan;

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = PVector.random2D().mult(random(1, 3));
    lifespan = 255; // Lifespan of the particle
  }

  void update() {
    position.add(velocity);
    lifespan -= 2; // Fade out over time
  }

  boolean isAlive() {
    return lifespan > 0;
  }

  abstract void display();
}

// Oscillating Particle
class OscillatingParticle extends Particle {
  float angle, amplitude;

  OscillatingParticle(float x, float y) {
    super(x, y);
    angle = random(TWO_PI);
    amplitude = random(5, 15); // Oscillation amplitude
  }

  void update() {
    super.update();
    angle += 0.1; // Oscillation speed
    position.y += sin(angle) * amplitude; // Oscillation along Y-axis
  }

  void display() {
    fill(100, 200, 255, lifespan);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}

// Fading Particle
class FadingParticle extends Particle {
  FadingParticle(float x, float y) {
    super(x, y);
  }

  void display() {
    fill(255, 150, 150, lifespan);
    noStroke();
    ellipse(position.x, position.y, 10, 10);
  }
}
