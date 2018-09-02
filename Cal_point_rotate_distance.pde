import controlP5.*;

ControlP5 cp5;

String textValue = "";

void setup() {
  size(640, 480);
  noSmooth();
  fill(126);
  background(102);

  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("input_X")
      .setCaptionLabel("X(m)")
      .setPosition(20,30)
      .setSize(200,40)
      .setFont(font)
      .setFocus(true)
      .setAutoClear(false)
      .setText("1")
      ;
                 
  cp5.addTextfield("input_Y")
      .setCaptionLabel("Y(m)")
      .setPosition(20,100)
      .setSize(200,40)
      .setFont(font)
      .setAutoClear(false)
      .setText("0")
      ;
                 
  cp5.addTextfield("input_Degree")
      .setCaptionLabel("Degree(°)")
      .setPosition(20,170)
      .setSize(200,40)
      .setFont(font)
      .setAutoClear(false)
      .setText("1")
      ;
       
  textFont(font);
}

void draw() {
  background(0);
  fill(255);
  float x, y, degree, rotate_distance, points_distance;
  String str;
  boolean error = false;

  str = cp5.get(Textfield.class,"input_X").getText();
  try {
    x = Float.parseFloat(str.trim());
  }
  catch (NumberFormatException e) {
    x = 0;
    error = true;
  }

  str = cp5.get(Textfield.class,"input_Y").getText();
  try {
    y = Float.parseFloat(str.trim());
  }
  catch (NumberFormatException e) {
    y = 0;
    error = true;
  }

  str = cp5.get(Textfield.class,"input_Degree").getText();
  try {
    degree = Float.parseFloat(str.trim());
  }
  catch (NumberFormatException e) {
    degree = 0;
    error = true;
  }

  //text(cp5.get(Textfield.class,"input_X").getText(), 360,60);
  //text(cp5.get(Textfield.class,"input_Y").getText(), 360,130);
  //text(cp5.get(Textfield.class,"input_Degree").getText(), 360,200);
  if (!error) {
    rotate_distance = get_point_rotate_distance(x, y, degree);
    points_distance = get_points_distance(0, 0, x, y);
    text("("+x+", "+y+", "+points_distance+") rotate "+degree+"° rotate_distance="+rotate_distance+"(m)", 20,280);
  }
  else {
    text("Input error!", 20,280);
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}

public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

float get_points_distance(float point_a_x, float point_a_y, float point_b_x, float point_b_y)
{
  float rotate_distance = (sqrt(sq(point_a_x - point_b_x) + sq(point_a_y - point_b_y)));
  //println("get_points_distance():"+"rotate_distance="+rotate_distance);
  return rotate_distance;
}

float get_point_rotate_distance(float point_x, float point_y, float degree)
{
  float point_rot_x, point_rot_y;
  point_rot_x = (point_x * cos(radians(degree)) - point_y * sin(radians(degree)));
  point_rot_y = (point_x * sin(radians(degree)) + point_y * cos(radians(degree)));
  //println("get_point_rotate_distance():"+"rotate_distance="+rotate_distance);
  return get_points_distance(point_x, point_y, point_rot_x, point_rot_y);
}
