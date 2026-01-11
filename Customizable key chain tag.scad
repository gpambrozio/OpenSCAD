// This module creates a labeled tag for use with keys or luggage

// Text to write on tag
tag_text = "Bike";

module key_tag(text) {
  font_size=6;
  $fn=100;
  hole_d=6;
  wall=2;
  thickness=1.75;
  text_thickness=1.4;
  difference() {
    hull() {
      translate([-7,0,0])
        cylinder(d=hole_d+2*wall,h=thickness);
      cylinder(d=font_size+3*wall,h=thickness);
      translate([ font_size*len(text)*0.9,0,0])
        cylinder(d=font_size+3*wall,h=thickness);
    }
    translate([-7,0,-1])
      cylinder(d=hole_d,h=5);
  }
  translate([0,0,thickness])
    linear_extrude(text_thickness)
      text(text, size=font_size, valign="center", halign="left", font="Arial Black");
}

key_tag(tag_text);
