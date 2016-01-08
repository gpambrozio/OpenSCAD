// From http://www.thingiverse.com/thing:102974

/* [Door parameters] */
// Door thickness (inner distance between front and back of door hook)
clip_depth = 44.8;
// Thickness of top and overhang (make sure it fits gap between door and frame)
top_and_back_thickness = 2.75;

/* [Hook parameters] */
// Width of entire hook
width = 30;
// Thickness of front piece and hanger hooks
hook_and_front_thickness = 4;
// Length of overhang on back side of the door
clip_length = 55;


number_of_hooks = 2;
// Distance between top of door and first hanger hook
first_hook_offset = 65;  // rounded: 60
// Distance between successive hanger hooks (if more than one)
hook_distance = 60;  // rounded: 60
// Radius of hanger hook curve
hook_radius = 15;

hook_style = "rounded"; // [simple:Simple,rounded:Rounded]

/* [Advanced] */

// Angle back of clip inwards (towards door), to help with friction; don't go crazy with this or you'll put too much stress on clip
clip_angle = 1;
// Add support buttress on hooks (except last); might help reduce flex, but looks a bit uglier (IMO)
inner_hook_buttress = 0; // [0:No,1:Yes]

double_sided = 1; // [0:No,1:Yes]

/* [Hidden] */

$fn = 72;
thickness = hook_and_front_thickness;
top_thickness = top_and_back_thickness;
back_thickness = double_sided ? thickness : top_thickness;

module hook_base() {
  difference() {
    cylinder(h=width, r=hook_radius+thickness);
    translate([0,0,-1])
      cylinder(h=width+2, r=hook_radius);
    translate([-hook_radius-thickness-1, 0, -1]) 
      cube([2*(hook_radius+thickness+1), hook_radius+thickness+1, width+2]); 
  }
}

module simple_hook() {
  translate([hook_radius+thickness, 0, 0]) union() {
    hook_base();
    translate([hook_radius+thickness/2, 0, 0])
      cylinder(h=width, r=thickness/2, $fn=18);
  }
}

module rounded_hook() {
  translate([0, -hook_radius-thickness, 0]) difference() {
    intersection() {
      cube([2*(hook_radius+thickness), 1.5*hook_radius+thickness+1, width]);
      translate([0, 0, width/2]) rotate([0, 90, 0]) cylinder(h=2*(hook_radius+thickness), r=1.5*hook_radius+thickness);
      translate([hook_radius+thickness, hook_radius+thickness, -1]) cylinder(r=hook_radius+thickness, h=width+2);
    }
    translate([hook_radius+thickness, hook_radius+thickness, -1]) cylinder(r=hook_radius, h=width+2);
    translate([-1, hook_radius+thickness, -1]) cube([hook_radius+thickness+2, hook_radius, width+2]);
  }
}

module hook() {
  if (hook_style == "simple") {
    simple_hook();
  } else if (hook_style == "rounded") {
    rounded_hook();
  }
}

module clip() {
  front_length = first_hook_offset + (number_of_hooks - 1) * hook_distance;
  back_length = double_sided ? front_length : clip_length;
  union() {
    translate([-clip_depth-back_thickness, 0, 0]) rotate([0, 0, clip_angle]) translate([0, -back_length, 0])
      cube([back_thickness, back_length, width]);
    translate([-clip_depth-back_thickness, 0, 0])
      cube([clip_depth + back_thickness + thickness, top_thickness, width]);
    translate([0, -front_length, 0])
      cube([thickness, front_length, width]);
  }
}

butt_theta = acos(hook_radius/(hook_radius+thickness));
module each_hook(i) {
  translate([0, -first_hook_offset-i*hook_distance+.1, 0]) union() {
    hook();
    if ((i < number_of_hooks-1) && (inner_hook_buttress != 0)) {
      translate([0,-(hook_radius+thickness)*tan(butt_theta),0]) rotate([0, 0, butt_theta]) translate([0, -thickness, 0]) cube([thickness*(1+1/cos(butt_theta)),thickness,width]);
    }
  }
}

module door_hook() {
  clip();
  for (i = [0:(number_of_hooks-1)]) {
    each_hook(i);
    if (double_sided) {
      translate([-clip_depth, 0, width])
      rotate([0, 0, clip_angle])
      rotate([0, 180, 0])
      each_hook(i);
    }
  }
}

door_hook();
