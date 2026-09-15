#ifdef GL_ES
precision mediump float;        // Set default float precision to medium for GL ES (mobile/embedded)
precision mediump int;          // Set default integer precision to medium for GL ES
#endif

#define PROCESSING_TEXTURE_SHADER        // Signals Processing that this shader processes texture frames

uniform sampler2D texture;        // Input texture sampler representing the rendered scene
uniform vec2 texOffset;           // Normalized size of a single pixel in texture space (1/width, 1/height)

varying vec4 vertColor;           // Incoming vertex color passed from the vertex shader
varying vec4 vertTexCoord;        // Incoming texture coordinate for the current fragment

void main(void) {
  // Grouping texcoord variables in order to make it work in the GMA 950. See post #13
  // in this thread:
  // http://www.idevgames.com/forums/thread-3467.html

  // Calculate 3x3 pixel neighborhood UV coordinates (top-left to bottom-right)
  vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t);        // Top-left neighbor
  vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t);        // Top-center neighbor
  vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t);        // Top-right neighbor
  vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0);        // Middle-left neighbor
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0);        // Center
  vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0);        // Middle-right neighbor
  vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t);        // Bottom-left neighbor
  vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t);        // Bottom-center neighbor
  vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t);        // Bottom-right neighbor

  // Sample RGBA color values for each of the 9 neighbor pixels
  vec4 col0 = texture2D(texture, tc0);
  vec4 col1 = texture2D(texture, tc1);
  vec4 col2 = texture2D(texture, tc2);
  vec4 col3 = texture2D(texture, tc3);
  vec4 col4 = texture2D(texture, tc4);
  vec4 col5 = texture2D(texture, tc5);
  vec4 col6 = texture2D(texture, tc6);
  vec4 col7 = texture2D(texture, tc7);
  vec4 col8 = texture2D(texture, tc8);

  // Apply a Laplacian edge-detection kernel matrix:
  // [ -1, -1, -1 ]
  // [ -1,  8, -1 ]
  // [ -1, -1, -1 ]
  vec4 sum = 8.0 * col4 - (col0 + col1 + col2 + col3 + col5 + col6 + col7 + col8); 

  // Output final fragment color with full opacity (alpha = 1.0) multiplied by vertex color
  gl_FragColor = vec4(sum.rgb, 1.0) * vertColor;
}
