# which tasks you have completed
1. Line algorithm: draw a straight line connecting the given start point (x1, y1) and endpoint (x2, y2).
2.	Circle Algorithm: draw a circle by the given center point (x, y) and its radius.
3.	Ellipse Algorithm: draw an ellipse by the given a center point (x, y), its major axis and minor axis.
4.	Bézier Curve Algorithm: draw a curve by the given start point p1, endpoint p2 and control point p3, p4.
5.	Eraser: clear the content of the given area defined by points p1 and p2 by clicking the mouse.

# some screenshots of your work
1. Line algorithm:
<img width="300" alt="image" src="https://github.com/user-attachments/assets/b1056aa8-6811-4168-b4af-cd99932175f6" />

2. Circle Algorithm:
<img width="300" alt="image" src="https://github.com/user-attachments/assets/012a0bbd-62c9-48f2-a9f4-6bfab546a3c0" />

3. Ellipse Algorithm:
<img width="300" alt="image" src="https://github.com/user-attachments/assets/5ae2e957-b8cf-416f-9eb1-0f930163aadd" />

4. Bézier Curve Algorithm
<img width="300" alt="image" src="https://github.com/user-attachments/assets/3c125b82-db5a-4eb5-9595-64d002226987" />

5. Eraser
<img width="300" alt="image" src="https://github.com/user-attachments/assets/3db8d046-960b-43af-8ff7-af0e4ce4e948" />

# how you completed these tasks
## Line algorithm
1. Calculate the initial decisive parameter:
```
        // Calculate the initial decisive parameter
        float d = a + 0.5f * b;
```
2. For the absolute of slope <= 1, if the decisive parameter <= 0, x-coordinate increments by 1; else, both x-coordinate and y-coordinate increment by 1:
```
        while (x != x2) 
        {
            if (d <= 0)
            {
                x += sx;
                d += a;
            }
            else
            {
                x += sx;
                y += sy;
                d += (a + b);
            }
            drawPoint(x, y, color(0,0,0));
        }
```
3. For the absolute of slope > 1, if the decisive parameter <= 0, y-coordinate increments by 1; else, both x-coordinate and y-coordinate increment by 1:
```
        while (y != y2) 
        {
            if (d <= 0)
            {
                y += sy;
                d += a;
            } 
            else
            {
                x += sx;
                y += sy;
                d += (a + b);
            }
            drawPoint(x, y, color(0,0,0));
        }
```
## Circle Algorithm
1. Calculate the initial decisive parameter:
```
    // Calculate the initial decisive parameter
    float p=(5f/4f)-r;
```
2. Draw the initial points in the 8 octants:
```
    // Draw the initial points in the 8 octants
    drawPoint(xc+x, yc+y, color(0,0,0));
    drawPoint(xc-x, yc+y, color(0,0,0));
    drawPoint(xc+x, yc-y, color(0,0,0));
    drawPoint(xc-x, yc-y, color(0,0,0));
    drawPoint(xc+y, yc+x, color(0,0,0));
    drawPoint(xc-y, yc+x, color(0,0,0));
    drawPoint(xc+y, yc-x, color(0,0,0));
    drawPoint(xc-y, yc-x, color(0,0,0));
```
3. When x<y, keep calculating in the first octant. If the mid-point is inside the circle, update the point to (x+1, y); else, update the point to (x+1, y-1):
```
    // When x<y, keep calculating in the first octant
    while(x<y)
    {
        // x increments 1 along the x axis
        x++;
        // If the mid-point is inside the circle, choose E
        if(p<0)
        {
            p+=2*x+1;
        }
        // If the mid-point is outside the circle, choose SE
        else
        {
            y--;
            p+=2*(x-y)+1;
        }
```
4. Draw the updated points in the 8 octants:
```
        // Draw the updated points in the 8 octants
        drawPoint(xc+x, yc+y, color(0,0,0));
        drawPoint(xc-x, yc+y, color(0,0,0));
        drawPoint(xc+x, yc-y, color(0,0,0));
        drawPoint(xc-x, yc-y, color(0,0,0));
        drawPoint(xc+y, yc+x, color(0,0,0));
        drawPoint(xc-y, yc+x, color(0,0,0));
        drawPoint(xc+y, yc-x, color(0,0,0));
        drawPoint(xc-y, yc-x, color(0,0,0));
```
## Ellipse Algorithm
1. Calculate the initial decision parameter for region 1 where slope magnitude < 1 and plot the points in region 1:
```
    // Initial decision parameter for Region 1 (slope magnitude < 1)
    d1 = (r2 * r2) - (r1 * r1 * r2) + (0.25f * r1 * r1);
    
    // Plotting points in region 1
    while (dx < dy)
    {
        // Draw the points in the 4 quadrants
        drawPoint(xc+x, yc+y, color(0,0,0));
        drawPoint(xc-x, yc+y, color(0,0,0));
        drawPoint(xc+x, yc-y, color(0,0,0));
        drawPoint(xc-x, yc-y, color(0,0,0));
```
2. Check and update the value of decision parameter. If the mid-point is inside the ellipse, update the point to (x+1, y); else, update the point to (x+1, y-1):
```
        // Checking and updating value of
        // decision parameter based on algorithm
        if (d1 < 0) 
        {
            // If the mid-point is inside the ellipse, choose E
            x++;
            dx = dx + (2 * r2 * r2);
            d1 = d1 + dx + (r2 * r2);
        }
        else
        {
            // If the mid-point is outside the ellipse, choose SE
            x++;
            y--;
            dx = dx + (2 * r2 * r2);
            dy = dy - (2 * r1 * r1);
            d1 = d1 + dx - dy + (r2 * r2);
        }
```
3. Calculate the initial decision parameter for region 2 where slope magnitude > 1 and plot the points in region 2:
```
    // Initial decision parameter for Region 2 (slope magnitude > 1)
    d2 = ((r2 * r2) * ((x + 0.5f) * (x + 0.5f))) + ((r1 * r1) * ((y - 1) * (y - 1))) - (r1 * r1 * r2 * r2);

    // Plotting points in region 2
    while (y >= 0) {
        // Draw the points in the 4 quadrants
        drawPoint(xc+x, yc+y, color(0,0,0));
        drawPoint(xc-x, yc+y, color(0,0,0));
        drawPoint(xc+x, yc-y, color(0,0,0));
        drawPoint(xc-x, yc-y, color(0,0,0));
```
4. Check and update the value of decision parameter. If the mid-point is outside the ellipse, update the point to (x, y-1); else, update the point to (x+1, y-1):
```
        // Checking and updating parameter
        // value based on algorithm
        if (d2 > 0) {
            // If the mid-point is outside the ellipse, choose S
            y--;
            dy = dy - (2 * r1 * r1);
            d2 = d2 + (r1 * r1) - dy;
        }
        else {
            // If the mid-point is inside the ellipse, choose SE
            y--;
            x++;
            dx = dx + (2 * r2 * r2);
            dy = dy - (2 * r1 * r1);
            d2 = d2 + dx - dy + (r1 * r1);
        }
```
## Bézier Curve Algorithm
1. Choose a small step size for a curve:
```
    // Choose a small step size for a curve
    float step = 0.001f;
```
2. Iterate 't' from 0.0 (start point p1) to 1.0 (end point p4) to trace the curve:
```
    // Iterate 't' from 0.0 (start point p1) to 1.0 (end point p4) to trace the curve
    for (float t = 0.0f; t <= 1.0f; t += step) {
        float u = 1.0f - t;
        float tt = t * t;
        float uu = u * u;
        float uuu = uu * u;
        float ttt = tt * t;
```
3. Calculate X and Y coordinates:
```
        // Calculate X and Y coordinates
        float x = uuu * p1.x + 3 * uu * t * p2.x + 3 * u * tt * p3.x + ttt * p4.x;
        float y = uuu * p1.y + 3 * uu * t * p2.y + 3 * u * tt * p3.y + ttt * p4.y;
```
## Eraser
1. Find the minimum and maximum bounds:
```
    // Find the minimum and maximum bounds
    float startX = Math.min(p1.x, p2.x);
    float endX = Math.max(p1.x, p2.x);
    float startY = Math.min(p1.y, p2.y);
    float endY = Math.max(p1.y, p2.y);
```
2. Loop through the rectangular area:
```
    // Loop through the rectangular area
    for (float x = startX; x <= endX; x++) {
        for (float y = startY; y <= endY; y++) {
            drawPoint(x, y, color(250));
        }
    }
```
