public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
    
    float dx = Math.abs(x2 - x1);
    float dy = Math.abs(y2 - y1);
    
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;

    float x=x1;
    float y=y1;
    
    if (dx >= dy) 
    {
        // Gentle slope
        float a = dy;
        float b = -dx;
        
        // Calculate the initial decisive parameter
        float d = a + 0.5f * b;
        
        drawPoint(x, y, color(0,0,0));
        
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
    } 
    else 
    {
        // Steep slope
        float a = dx;
        float b = -dy;
        
        // Calculate the initial decisive parameter
        float d = a + 0.5f * b;
        
        drawPoint(x, y, color(0,0,0));
        
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
    }

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    float xc=x;
    float yc=y;
    x = 0;
    y = r;
    
    // Calculate the initial decisive parameter
    float p=(5f/4f)-r;
    
    // Draw the initial points in the 8 octants
    drawPoint(xc+x, yc+y, color(0,0,0));
    drawPoint(xc-x, yc+y, color(0,0,0));
    drawPoint(xc+x, yc-y, color(0,0,0));
    drawPoint(xc-x, yc-y, color(0,0,0));
    drawPoint(xc+y, yc+x, color(0,0,0));
    drawPoint(xc-y, yc+x, color(0,0,0));
    drawPoint(xc+y, yc-x, color(0,0,0));
    drawPoint(xc-y, yc-x, color(0,0,0));
    
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
        // Draw the updated points in the 8 octants
        drawPoint(xc+x, yc+y, color(0,0,0));
        drawPoint(xc-x, yc+y, color(0,0,0));
        drawPoint(xc+x, yc-y, color(0,0,0));
        drawPoint(xc-x, yc-y, color(0,0,0));
        drawPoint(xc+y, yc+x, color(0,0,0));
        drawPoint(xc-y, yc+x, color(0,0,0));
        drawPoint(xc+y, yc-x, color(0,0,0));
        drawPoint(xc-y, yc-x, color(0,0,0));
    }

    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    float xc=x;
    float yc=y;
    float dx, dy, d1, d2;
    x = 0;
    y = r2;
    
    dx = 2 * r2 * r2 * x;
    dy = 2 * r1 * r1 * y;

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
    }

    // Initial decision parameter for Region 2 (slope magnitude > 1)
    d2 = ((r2 * r2) * ((x + 0.5f) * (x + 0.5f))) + ((r1 * r1) * ((y - 1) * (y - 1))) - (r1 * r1 * r2 * r2);

    // Plotting points in region 2
    while (y >= 0) {
        // Draw the points in the 4 quadrants
        drawPoint(xc+x, yc+y, color(0,0,0));
        drawPoint(xc-x, yc+y, color(0,0,0));
        drawPoint(xc+x, yc-y, color(0,0,0));
        drawPoint(xc-x, yc-y, color(0,0,0));

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
    }

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    // Choose a small step size for a curve
    float step = 0.001f;
    
    // Iterate 't' from 0.0 (start point p1) to 1.0 (end point p4) to trace the curve
    for (float t = 0.0f; t <= 1.0f; t += step) {
        float u = 1.0f - t;
        float tt = t * t;
        float uu = u * u;
        float uuu = uu * u;
        float ttt = tt * t;
        
        // Calculate X and Y coordinates
        float x = uuu * p1.x + 3 * uu * t * p2.x + 3 * u * tt * p3.x + ttt * p4.x;
        float y = uuu * p1.y + 3 * uu * t * p2.y + 3 * u * tt * p3.y + ttt * p4.y;
        
        // Draw each point
        drawPoint(x, y, color(0));
    }

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    // Find the minimum and maximum bounds
    float startX = Math.min(p1.x, p2.x);
    float endX = Math.max(p1.x, p2.x);
    float startY = Math.min(p1.y, p2.y);
    float endY = Math.max(p1.y, p2.y);
    
    // Loop through the rectangular area
    for (float x = startX; x <= endX; x++) {
        for (float y = startY; y <= endY; y++) {
            drawPoint(x, y, color(250));
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
