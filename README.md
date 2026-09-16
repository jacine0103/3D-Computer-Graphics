## Completed Tasks

#### 3D Scene Rendering & Selective Filtering
1. Configured a 3D Processing sketch set to `P3D` render mode.
2. Created a rotating, lit 3D box (`box(120)`) transformed using `pushMatrix()`, `rotateX()`, `rotateY()`, and `popMatrix()`.
3. Applied the post-processing edge detection shader using `filter(edges)` conditionally via the `applyFilter` boolean.
4. Positioned a separate 3D sphere (`sphere(40)`) rendered after the `filter()` call to demonstrate selective shader application, leaving the sphere unfiltered.
5. Implemented an interactive toggle via `mousePressed()` to switch `applyFilter` between `true` and `false`.
#### GLSL Edge Detection Shader
1. Written an OpenGL ES-compatible GLSL fragment shader (`edges.glsl`) implementing a Laplacian convolution kernel for edge detection.
2. Configured uniform variables `sampler2D texture` (the main render buffer) and `vec2 texOffset` (pixel offset based on canvas dimensions).
3. Sampled a 3*3 pixel grid (`tc0` through `tc8`) around the target fragment using calculated texture offsets.
4. Applied the kernel math: $\text{sum} = 8.0 \times \text{col4} - (\sum_{i \neq 4} \text{col}_i)$, isolating high-frequency spatial color changes (edges).
5. Outputted the final edge-detected color result to `gl_FragColor` scaled by `vertColor`.

---

## Screenshot

<img width="544" height="338" alt="image" src="https://github.com/user-attachments/assets/c13a5d83-b245-42f3-b4ce-d60d8e27acee" />
<img width="543" height="336" alt="image" src="https://github.com/user-attachments/assets/a40c8df2-31b1-43ff-9d3a-77ba8ae86913" />

---

## How to complete these tasks

1.	Shader Compilation & Loading: In `setup()`, `loadShader("edges.glsl")` compiles the fragment shader and links uniform variables (`texture` and `texOffset`) automatically supplied by Processing.
2.	Execution Order Mechanics: Calling `filter(edges)` immediately captures the current frame buffer (containing the rendered rotating box) and executes the GLSL fragment shader across all pixels. Objects drawn after the `filter()` call (the revolving sphere) bypass the shader pass, leaving them fully lit without edge outlines.
3.	GPU Convolution Strategy: The shader samples surrounding texture coordinates (`tc0`–`tc8`) using `texOffset` to manually construct adjacent pixel coordinates, ensuring cross-hardware compatibility (including older Intel GMA GPUs) while performing real-time image processing on the GPU.
