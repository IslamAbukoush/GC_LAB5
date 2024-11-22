int cols, rows; // Number of columns and rows in the grid
int cellSize = 10; // Size of each cell
boolean[][] grid, nextGrid; // Current and next state grids
boolean isPaused = true; // Game starts paused

void setup() {
  size(600, 600); // Canvas size
  fullScreen();
  cols = width / cellSize;
  rows = height / cellSize;
  grid = new boolean[cols][rows];
  nextGrid = new boolean[cols][rows];
  frameRate(10);
}

void draw() {
  background(255);
  drawGrid();
  
  if (!isPaused) {
    updateGrid();
  }
}

// Toggle between alive and dead cells when clicked
void mousePressed() {
  int x = mouseX / cellSize;
  int y = mouseY / cellSize;
  if (x >= 0 && x < cols && y >= 0 && y < rows) {
    grid[x][y] = !grid[x][y]; // Toggle the state
  }
}

// Toggle pause with SPACE
void keyPressed() {
  if (key == ' ') {
    isPaused = !isPaused;
  }
}

// Draw the grid and cells
void drawGrid() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (grid[x][y]) {
        fill(0); // Alive cell
      } else {
        fill(255); // Dead cell
      }
      stroke(200); // Grid lines
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }
}

// Update the grid based on Game of Life rules
void updateGrid() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int neighbors = countNeighbors(x, y);
      
      // Apply rules of Game of Life
      if (grid[x][y]) {
        // Alive cell
        nextGrid[x][y] = (neighbors == 2 || neighbors == 3);
      } else {
        // Dead cell
        nextGrid[x][y] = (neighbors == 3);
      }
    }
  }
  
  // Swap grids
  boolean[][] temp = grid;
  grid = nextGrid;
  nextGrid = temp;
}

// Count alive neighbors of a cell
int countNeighbors(int x, int y) {
  int count = 0;
  for (int dx = -1; dx <= 1; dx++) {
    for (int dy = -1; dy <= 1; dy++) {
      if (dx == 0 && dy == 0) continue; // Skip the current cell
      int nx = x + dx;
      int ny = y + dy;
      if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
        if (grid[nx][ny]) count++;
      }
    }
  }
  return count;
}
