# Completed tasks
1. 3 transformation matrices: Translation Matrix, Rotation Matrix (Z-axis), Scaling Matrix
2.	`pnpoly` function
3.	`findBoundBox` function
4.	Sutherland Hodgman Algorithm

# Screenshots
### Complete 3 transformation matrices
<img width="500" alt="Screenshot 2026-11-15 214314" src="https://github.com/user-attachments/assets/3c2b6431-0dc8-443c-8db4-1b0767275a09" />

### Complete `pnpoly` function, `findBoundBox` function, Sutherland Hodgman Algorithm
<img width="500" alt="Screenshot 2026-11-15 223438" src="https://github.com/user-attachments/assets/7d2ead98-c892-4e41-90bc-7ace231e2d81" />

# How to complete the tasks
### 3 transformation matrices: 
1. Translation Matrix
```
  void makeTrans(Vector3 t) {
    // TODO HW2
    // You need to implement the translate matrix here.
    makeIdentity();
    m[3] = t.x;
    m[7] = t.y;
    m[11] = t.z;
  }
```
2. Rotation Matrix (Z-axis)
```
  void makeRotZ(float a) {
     // TODO HW2
     // You need to implement the rotation of z-axis matrix here. (Yaw)
    makeIdentity();
    m[0] = cos(a);
    m[1] = -sin(a);
    m[4] = sin(a);
    m[5] = cos(a);
  }
```
3. Scaling Matrix
```
  void makeScale(Vector3 s) {
    // TODO HW2
    // You need to implement the scale matrix here.
    makeIdentity();
    m[0] = s.x;
    m[5] = s.y;
    m[10] = s.z;
  }
```
---
### `pnpoly` function:
#### Check each edge of the polygon.
```
    for (int i = 0, j = n - 1; i < n; j = i++) {
      float xi = vertexes[i].x, yi = vertexes[i].y;
      float xj = vertexes[j].x, yj = vertexes[j].y;
```
#### Check if the horizontal ray intersects the edge between vertex j and vertex i.
```
      // Check if the horizontal ray intersects the edge between vertex j and vertex i
      boolean intersect = ((yi > y) != (yj > y)) &&
                          (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
```
1. `((yi > y) != (yj > y))`: check if y is between yi and yj.
2. `x < (xj - xi) * (y - yi) / (yj - yi) + xi`: check if x < the x coordinate of the intersection of the ray and the edge.
---
### `findBoundBox` function:
```
    for (Vector3 vertex : v) {
        recordminV.x = Math.min(recordminV.x, vertex.x);
        recordminV.y = Math.min(recordminV.y, vertex.y);
        recordminV.z = Math.min(recordminV.z, vertex.z);

        recordmaxV.x = Math.max(recordmaxV.x, vertex.x);
        recordmaxV.y = Math.max(recordmaxV.y, vertex.y);
        recordmaxV.z = Math.max(recordmaxV.z, vertex.z);
    }
```
Find the minimum x coordinate and y coordinate and maximum coordinate and y coordinate.

---
### Sutherland Hodgman Algorithm:
```
      Vector3 S = input.get(input.size() - 1);
      for (int j = 0; j < input.size(); j++) {
        Vector3 E = input.get(j);
  
        if (isInside(E, A, B, orientation)) {
          if (!isInside(S, A, B, orientation)) {
            output.add(computeIntersection(S, E, A, B));
          }
          output.add(E);
        } else if (isInside(S, A, B, orientation)) {
          output.add(computeIntersection(S, E, A, B));
        }
  
        S = E;
      }
      input = output;
    }
```
If E is inside the boundary and S is outside the boundary, or S is inside the boundary and E is outside the boundary, then calculate the intersection.
