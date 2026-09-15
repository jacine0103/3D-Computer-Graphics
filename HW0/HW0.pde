/**
 * Edge Filter
 * 
 * Apply a custom shader to the filter() function to affect the geometry drawn to the screen.
 * 
 * Press the mouse to turn the filter on and off.
 */
 
PShader edges;                 // Shader object to hold the loaded GLSL fragment shader
boolean applyFilter = true;    // Toggle flag to enable or disable the shader filter

void setup() {
  size(640, 360, P3D);
  edges = loadShader("edges.glsl");    // Load the custom GLSL edge-detection fragment shader
  noStroke(); 
}

void draw() {
  background(0);
  lights();

  // Center the coordinate system origin (0, 0) to the middle of the canvas
  translate(width/2, height/2);  

  pushMatrix();                  // Isolate transformations (rotations) for the box
  rotateX(frameCount * 0.01);    // Continuously rotate the box around the X-axis over time
  rotateY(frameCount * 0.01);    // Continuously rotate the box around the Y-axis over time
  box(120);
  popMatrix();                   // Restore the transformation matrix (removes box-specific rotation)

  // Apply the post-processing edge detection shader if enabled
  if (applyFilter == true) {
    filter(edges);    // Applies the shader to the current frame canvas buffer
  }
  
  // The sphere doesn't have the edge detection applied 
  // on it because it is drawn after filter() is called.
  rotateY(frameCount * 0.02);    // Orbit the sphere around the Y-axis
  translate(150, 0);             // Position the sphere 150 units away from the center
  sphere(40);
}

// Event handler triggered whenever a mouse button is clicked
void mousePressed() {
  applyFilter = !applyFilter;
}
