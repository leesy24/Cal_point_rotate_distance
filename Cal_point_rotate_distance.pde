void setup() {
  size(640, 360);
  noSmooth();
  fill(126);
  background(102);
}

void draw() {
  if (mousePressed) {
    stroke(255);
  } else {
    stroke(0);
  }
  line(mouseX-66, mouseY, mouseX+66, mouseY);
  line(mouseX, mouseY-66, mouseX, mouseY+66);
  println("50x20 Rotate 0.09 distance="+get_point_rotate_distance(50*100,20*100,0.09)/100.);
  println("20x50 Rotate 0.09 distance="+get_point_rotate_distance(20*100,50*100,0.09)/100.);
}

int get_points_distance(int point_a_x, int point_a_y, int point_b_x, int point_b_y)
{
  int distance = int(sqrt(sq(point_a_x - point_b_x) + sq(point_a_y - point_b_y)));
  //println("get_points_distance():"+"distance="+distance);
  return distance;
}

int get_point_rotate_distance(int point_x, int point_y, float degree)
{
  int point_rot_x, point_rot_y;
  point_rot_x = int(point_x * cos(radians(degree)) - point_y * sin(radians(degree)));
  point_rot_y = int(point_x * sin(radians(degree)) + point_y * cos(radians(degree)));
  //println("get_point_rotate_distance():"+"distance="+distance);
  return get_points_distance(point_x, point_y, point_rot_x, point_rot_y);
}
