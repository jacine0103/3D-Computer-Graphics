public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
    float dx = x2 - x1;
    float dy = y2 - y1;
    float steps = max(abs(dx), abs(dy));

    if (steps == 0) {
        drawPoint(round(x1), round(y1), color(0));
        return;
    }

    float xInc = dx / steps;
    float yInc = dy / steps;

    float x = x1;
    float y = y1;
    for (int i = 0; i <= steps; i++) {
        drawPoint(round(x), round(y), color(0));
        x += xInc;
        y += yInc;
    }
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.

    boolean inside = false;
    int n = vertexes.length;
    
    for (int i = 0, j = n - 1; i < n; j = i++) {
      float xi = vertexes[i].x, yi = vertexes[i].y;
      float xj = vertexes[j].x, yj = vertexes[j].y;
      
      // Check if the horizontal ray intersects the edge between vertex j and vertex i
      boolean intersect = ((yi > y) != (yj > y)) &&
                          (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
                          
      if (intersect) {
        inside = !inside;
      }
    }
    
    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    
    
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2

    Vector3 recordminV = new Vector3(Float.POSITIVE_INFINITY);
    Vector3 recordmaxV = new Vector3(Float.NEGATIVE_INFINITY);
    
    for (Vector3 vertex : v) {
        recordminV.x = Math.min(recordminV.x, vertex.x);
        recordminV.y = Math.min(recordminV.y, vertex.y);
        recordminV.z = Math.min(recordminV.z, vertex.z);

        recordmaxV.x = Math.max(recordmaxV.x, vertex.x);
        recordmaxV.y = Math.max(recordmaxV.y, vertex.y);
        recordmaxV.z = Math.max(recordmaxV.z, vertex.z);
    }
    
    Vector3[] result = { recordminV, recordmaxV };
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.

    if (input.size() == 0 || boundary.length < 3) {
      return new Vector3[0];
    }
    
    // Determine boundary winding order using the shoelace formula
    float signedArea = 0;
    for (int i = 0; i < boundary.length; i++) {
      Vector3 curr = boundary[i];
      Vector3 next = boundary[(i + 1) % boundary.length];
      signedArea += (curr.x * next.y - next.x * curr.y);
    }
    float orientation = (signedArea >= 0) ? 1.0f : -1.0f;

    // Iterate through each clipping edge (A -> B) of the boundary
    for (int i = 0; i < boundary.length; i++) {
      Vector3 A = boundary[i];
      Vector3 B = boundary[(i + 1) % boundary.length];
  
      output = new ArrayList<Vector3>();
      if (input.size() == 0) break;
  
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

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

boolean isInside(Vector3 P, Vector3 A, Vector3 B, float orientation) {
  float crossProduct = (B.x - A.x) * (P.y - A.y) - (B.y - A.y) * (P.x - A.x);
  return (crossProduct * orientation) >= 0;
}

Vector3 computeIntersection(Vector3 S, Vector3 E, Vector3 A, Vector3 B) {
  float dx1 = E.x - S.x;
  float dy1 = E.y - S.y;
  float dx2 = B.x - A.x;
  float dy2 = B.y - A.y;

  float denom = dx1 * dy2 - dy1 * dx2;
  if (abs(denom) < 1e-6) {
    return E;
  }

  float t = ((A.x - S.x) * dy2 - (A.y - S.y) * dx2) / denom;
  float ix = S.x + t * dx1;
  float iy = S.y + t * dy1;
  
  return new Vector3(ix, iy, S.z);
}
